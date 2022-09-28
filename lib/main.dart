import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optical_character_recognizer/firebase_options.dart';
import 'package:optical_character_recognizer/routes.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/screens/home/home_screen.dart';

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
    final firebaseAuth = FirebaseAuth.instance;
    return GetMaterialApp(
      title: 'Character Recognizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: firebaseAuth.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      onGenerateRoute: CustomRoutes.onGenerateRoute,
    );
  }
}
