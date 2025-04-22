import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withAlpha(200),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35),
                ),
                SizedBox(height: 10),
                Text(
                  'Student Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Roll Number: 12345',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          _buildMenuItem(context, 'Assignments', Icons.assignment),
          _buildMenuItem(context, 'Backlog Registration', Icons.history),
          _buildMenuItem(context, 'Doctor Appointment', Icons.medical_services),
          _buildMenuItem(context, 'Document Upload', Icons.file_upload),
          _buildMenuItem(context, 'Teacher on Leave', Icons.person_off),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          '/${title.toLowerCase().replaceAll(' ', '_')}',
        );
      },
    );
  }
}
