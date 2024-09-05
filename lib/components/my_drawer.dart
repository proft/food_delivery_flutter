import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/components/my_drawer_tile.dart';
import 'package:food_delivery_flutter/services/auth_service.dart';
import 'package:food_delivery_flutter/views/settings_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() async {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(25),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              )),
          MyDrawerTile(text: "Home", icon: Icons.home, onTap: () => Navigator.pop(context)),
          MyDrawerTile(text: "Settings", icon: Icons.settings, onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
          }),
          const Spacer(),
          MyDrawerTile(text: "Log out", icon: Icons.logout, onTap: logout),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
