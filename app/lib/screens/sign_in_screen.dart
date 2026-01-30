import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import '../main.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import '../design_system/core/oisely_colors.dart';
import 'main_shell.dart';
import 'sign_in_components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({required this.sessionManager, super.key});

  final SessionManager sessionManager;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isEmailSent = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      if (email.isEmpty || !email.contains('@')) {
        setState(() {
          _errorMessage = 'Please enter a valid email address.';
          _isLoading = false;
        });
        return;
      }

      final success = await client.magicLink.sendMagicLink(email);

      if (success) {
        setState(() {
          _isEmailSent = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to send code. Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyCode(String code) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final response = await client.magicLink.verifyMagicLink(email, code);

      if (response.success) {
        await widget.sessionManager.registerSignedInUser(
          response.userInfo!,
          response.keyId!,
          response.key!,
        );

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => AuthProvider(widget.sessionManager),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => NavigationProvider(),
                  ),
                ],
                child: const MainShellWrapper(),
              ),
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid or expired code.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _isEmailSent = false;
      _otpController.clear();
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OiselyColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check for desktop/tablet landscape
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                // Left Side: Hero
                const Expanded(
                  flex: 5,
                  child: AuthHeroSection(),
                ),
                // Right Side: Form
                Expanded(
                  flex: 4,
                  child: Container(
                    color: OiselyColors.background,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: _buildFormContent(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile: Stacked
            return SingleChildScrollView(
              child: Column(
                children: [
                  const AuthHeroSection(),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 300, // Approximate hero height
                    ),
                    color: OiselyColors.background,
                    child: _buildFormContent(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFormContent() {
    if (_isEmailSent) {
      return AuthCodeVerifySection(
        email: _emailController.text,
        otpController: _otpController,
        isLoading: _isLoading,
        onVerify: _verifyCode,
        onRetry: _reset,
        errorMessage: _errorMessage,
      );
    } else {
      return AuthFormSection(
        emailController: _emailController,
        isLoading: _isLoading,
        onSendCode: _sendCode,
        errorMessage: _errorMessage,
      );
    }
  }
}
