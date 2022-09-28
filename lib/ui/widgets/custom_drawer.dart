import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/core/services/auth_service.dart';
import 'package:optical_character_recognizer/ui/screens/auth/change_password_screen.dart';
import 'package:optical_character_recognizer/ui/screens/auth/login_screen.dart';
import 'package:optical_character_recognizer/ui/screens/breweries/breweries_list_screen.dart';
import 'package:optical_character_recognizer/ui/screens/google_map/map_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                // radius: 50.0,
                radius: MediaQuery.of(context).size.height * .07,
                backgroundImage: const AssetImage(
                  'assets/images/faizan_image.jpg',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Faizan",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  // color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Divider(
                height: 1.0,
                thickness: 1.0,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ChangePasswordScreen.routeName);
          },
          leading: const Icon(
            Icons.password,
            // color: Colors.white,
          ),
          title: const Text(
            "Change Password",
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MapScreen.routeName);
          },
          leading: const Icon(
            Icons.location_on,
            // color: Colors.white,
          ),
          title: const Text(
            "Nearest BRT Stations",
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, BreweriesListScreen.routeName);
          },
          leading: const Icon(
            Icons.access_alarm_outlined,
            // color: Colors.white,
          ),
          title: const Text(
            "Breweries List",
          ),
        ),
        ListTile(
          onTap: () async {
            AuthService().signOut().then((value) {
              Navigator.pushNamed(context, LoginScreen.routeName);
            });
          },
          leading: const Icon(
            Icons.logout,
            // color: Colors.white,
          ),
          title: const Text(
            "Logout",
          ),
        ),
      ]),
    );
  }
}
