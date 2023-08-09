import 'package:blckchain_movile/screens/screens.dart';
import 'package:blckchain_movile/services/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const CheckAuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}


