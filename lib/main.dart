import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'screens/SignUpPage.dart';
import 'screens/Login_page.dart';
import 'screens/home_screen.dart';
import 'screens/Profile_page.dart';

import 'amplifyconfiguration.dart';
import 'screens/MainScreenState.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      AmplifyAPI apiPlugin = AmplifyAPI();

      // Adiciona os plugins ao Amplify
      await Amplify.addPlugin(authPlugin);
      await Amplify.addPlugin(apiPlugin);

      // Configura o Amplify
      await Amplify.configure(amplifyconfig);

      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FisioFIT',
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/main': (context) => const MainScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF66FFCC),
          onPrimary: Color(0xFF66FFCC),
          primaryContainer: Color(0xFF66FFCC),
          secondary: Color(0xFF66FFCC),
          onSecondary: Color(0xFF66FFCC),
          secondaryContainer: Color(0xFF66FFCC),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF66FFCC)),
          headline6: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFF66FFCC)),
          bodyText2: TextStyle(fontSize: 14.0, color: Color(0xFF66FFCC)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, // Text color
            backgroundColor: Color(0xFF66FFCC), // Botao background color
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF66FFCC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF66FFCC)),
          ),
          labelStyle: TextStyle(color: Color(0xFF66FFCC)),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF66FFCC),
          size: 24.0,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          titleTextStyle: TextStyle(
              color: Color(0xFF66FFCC),
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        // Define additional theme data here...
      ),
      home: const MainScreen(),
    );
  }
}
