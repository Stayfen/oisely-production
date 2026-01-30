import 'dart:convert';
import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'design_system/design_system.dart';
import 'models/animal.dart';
import 'providers/adoption_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/animal_detail_screen.dart';
import 'screens/main_shell.dart';
import 'screens/sign_in_screen.dart';
import 'widgets/error_dialog.dart';
import 'widgets/loading_overlay.dart';
import 'package:uuid/uuid.dart';

String _serverUrl() {
  if (kIsWeb) {
    return 'http://localhost:8080/';
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8080/';
  }
  return 'http://localhost:8080/';
}

final client = Client(
  _serverUrl(),
  authenticationKeyManager: FlutterAuthenticationKeyManager(),
  connectionTimeout: const Duration(seconds: 120),
)..connectivityMonitor = FlutterConnectivityMonitor();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('main: starting');
  runApp(const AppBootstrap());
}

/// App bootstrap handles the initial session manager initialization
class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap>
    with WidgetsBindingObserver {
  late final Future<SessionManager> _sessionManagerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('AppBootstrap initState');
    _sessionManagerFuture = _initializeSessionManager();
  }

  Future<SessionManager> _initializeSessionManager() async {
    final sessionManager = SessionManager(
      caller: client.modules.auth,
    );
    final stopwatch = Stopwatch()..start();
    try {
      await sessionManager.initialize().timeout(const Duration(seconds: 8));
      debugPrint(
        'SessionManager.initialize completed in ${stopwatch.elapsedMilliseconds}ms',
      );
    } catch (e) {
      debugPrint('SessionManager.initialize failed: $e');
    } finally {
      stopwatch.stop();
    }
    return sessionManager;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('lifecycle: $state');
  }

  @override
  void dispose() {
    debugPrint('AppBootstrap dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SessionManager>(
      future: _sessionManagerFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AuthProvider(snapshot.data!),
              ),
              ChangeNotifierProvider(
                create: (_) => NavigationProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => AdoptionProvider(),
              ),
            ],
            child: MyApp(sessionManager: snapshot.data!),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Startup failed',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _sessionManagerFuture = _initializeSessionManager();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const MaterialApp(home: SplashScreen());
      },
    );
  }
}

/// Splash screen shown during initialization
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// Main app widget with MaterialApp configuration
class MyApp extends StatelessWidget {
  const MyApp({required this.sessionManager, super.key});

  final SessionManager sessionManager;

  @override
  Widget build(BuildContext context) {
    debugPrint('MyApp build');
    return MaterialApp(
      title: 'Oisely',
      debugShowCheckedModeBanner: false,
      theme: OiselyTheme.lightTheme,
      home: sessionManager.signedInUser != null
          ? const MainShellWrapper()
          : SignInScreen(sessionManager: sessionManager),
    );
  }
}

/// Wrapper for MainShell that handles image processing
class MainShellWrapper extends StatefulWidget {
  const MainShellWrapper({super.key});

  @override
  State<MainShellWrapper> createState() => _MainShellWrapperState();
}

class _MainShellWrapperState extends State<MainShellWrapper> {
  bool _isProcessingImage = false;
  File? _pendingImage;

  Future<void> _processImage(File imageFile) async {
    setState(() {
      _isProcessingImage = true;
      _pendingImage = imageFile;
    });

    try {
      // Validate file size (max 10MB before compression)
      final fileSize = await imageFile.length();
      if (fileSize > 10 * 1024 * 1024) {
        throw Exception('Image size exceeds 10MB limit');
      }

      // Compress image before sending
      final compressedFile = await _compressImage(imageFile);

      // Read and encode to base64
      final bytes = await compressedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Call the API with 30-second timeout
      final adoptionInfo = await client.animalIdentification
          .identifyAnimal(base64Image)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('timeout');
            },
          );

      // Create animal object and add to provider
      final animal = Animal(
        id: const Uuid().v4(),
        species: adoptionInfo.species,
        breed: adoptionInfo.breed,
        imageUrl: '', // We use local image path instead
        identifiedAt: DateTime.now(),
        isAdopted: false,
        adoptionInfo: adoptionInfo,
        localImagePath: compressedFile.path,
      );

      final adoptionProvider = context.read<AdoptionProvider>();
      await adoptionProvider.addAnimal(animal);

      if (mounted) {
        setState(() {
          _isProcessingImage = false;
        });

        // Navigate to detail page with shared axis transition
        await Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                AnimalDetailScreen(animal: animal),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.scaled,
                    child: child,
                  );
                },
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingImage = false;
        });

        final errorType = getErrorType(e);
        showErrorModal(
          context: context,
          type: errorType,
          customMessage: e.toString().contains('10MB')
              ? 'Image is too large. Please select an image smaller than 10MB.'
              : null,
          onRetry: () => _processImage(imageFile),
        );
      }
    }
  }

  Future<File> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 85,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result != null) {
      return File(result.path);
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayWrapper(
      isLoading: _isProcessingImage,
      message: 'Processing Image',
      child: MainShell(
        onImageSelected: _processImage,
      ),
    );
  }
}
