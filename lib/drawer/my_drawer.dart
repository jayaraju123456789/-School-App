import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Gamefied_Dachboard/gamified_dashboard.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text(
                "JayRaj",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                "Vishalactive@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/gate.jpg"),
              ),
            ),
          ),
          // Drawer Menu Items
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text("Home", style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Navigate to home or other functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text("Profile", style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.blue),
            title: const Text("Settings", style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings page
            },
          ),
          ListTile(
            leading: const Icon(Icons.gamepad_rounded, color: Colors.blue),
            title: const Text("Game dashboard", style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GamifiedDashboard()),
              );
            },
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
              // Add logout functionality
            },
          ),
        ],
      ),
    );
  }
}
