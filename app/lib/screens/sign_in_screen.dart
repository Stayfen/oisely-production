import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    // Set status bar style for better visibility on dark hero section
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

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
          if (constraints.maxWidth > 900) {
            return Row(
              children: [
                // Left Side: Hero - takes up more space
                Expanded(
                  flex: 6,
                  child: const AuthHeroSection(),
                ),
                // Right Side: Form with subtle shadow
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: OiselyColors.background,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          blurRadius: 30,
                          offset: const Offset(-10, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: _buildFormContent(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile: Full screen with scrollable content
            return Container(
              color: OiselyColors.background,
              child: CustomScrollView(
                slivers: [
                  // Hero section with dynamic height
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.585,
                      child: const AuthHeroSection(),
                    ),
                  ),
                  // Form section
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: OiselyColors.background,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      // Overlap the hero section slightly
                      transform: Matrix4.translationValues(0, -24, 0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        child: Container(
                          color: OiselyColors.background,
                          child: _buildFormContent(),
                        ),
                      ),
                    ),
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
