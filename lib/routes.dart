import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/core/models/brewery.dart';
import 'package:optical_character_recognizer/ui/screens/auth/change_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/forgot_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/sign_up_screen.dart';
import 'package:optical_character_recognizer/ui/screens/breweries/breweries_details_screen.dart';
import 'package:optical_character_recognizer/ui/screens/breweries/breweries_list_screen.dart';
import 'package:optical_character_recognizer/ui/screens/google_map/map_screen.dart';
import 'package:optical_character_recognizer/ui/screens/home/home_screen.dart';

class CustomRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case BreweriesListScreen.routeName:
        return MaterialPageRoute(builder: (_) => BreweriesListScreen());

      case BreweryDetailsScreen.routeName:
        final args = settings.arguments as Brewery;
        return MaterialPageRoute(
            builder: (_) => BreweryDetailsScreen(
                  brewery: args,
                ));

      case MapScreen.routeName:
        return MaterialPageRoute(builder: (_) => MapScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
