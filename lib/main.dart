import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/firebase_options.dart';
import 'package:optical_character_recognizer/routes.dart';
import 'package:optical_character_recognizer/ui/screens/auth/change_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/forgot_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/sign_up_screen.dart';
import 'package:optical_character_recognizer/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _firebaseAuth = FirebaseAuth.instance;
    return MaterialApp(
      title: 'Character Recognizer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: _firebaseAuth.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      onGenerateRoute: CustomRoutes.onGenerateRoute,
    );
  }
}
