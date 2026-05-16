import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF080B12),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const SmartSecureApp());
}

class SmartSecureApp extends StatelessWidget {
  const SmartSecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSecure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080B12),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF5A623),
          secondary: Color(0xFF00C9A7),
          surface: Color(0xFF111624),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF111624),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0x12FFFFFF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0x12FFFFFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFF5A623), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE05A7A)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE05A7A), width: 1.5),
          ),
          hintStyle: GoogleFonts.dmSans(color: const Color(0xFF6A7090), fontSize: 14),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Color(0xFFEEF0F6)),
          titleTextStyle: GoogleFonts.syne(
            fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFFEEF0F6),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':        (_) => const SplashScreen(),
        '/login':   (_) => const LoginScreen(),
        '/register':(_) => const RegisterScreen(),
        '/home':    (_) => const _HomePlaceholder(),
      },
    );
  }
}

// Temporary home placeholder until we build the real home screen
class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFF5A623), Color(0xFFE8920A)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.lock_rounded, color: Color(0xFF080B12), size: 36),
            ),
            const SizedBox(height: 24),
            Text(
              'You\'re in! 🎉',
              style: GoogleFonts.syne(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFFEEF0F6)),
            ),
            const SizedBox(height: 8),
            Text(
              'Home screen coming next.',
              style: GoogleFonts.dmSans(fontSize: 15, color: const Color(0xFF6A7090)),
            ),
          ],
        ),
      ),
    );
  }
}
