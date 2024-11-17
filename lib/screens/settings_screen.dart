import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: true, // Enables back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Setting
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: true, // This should be linked to a state variable
              onChanged: (bool value) {
                // Handle toggle notifications here
              },
            ),

            // Theme Setting
            SizedBox(height: 20),
            Text(
              'Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Light Theme'),
              leading: Radio(
                value: 'light',
                groupValue:
                    'theme', // This should be linked to a state variable
                onChanged: (value) {
                  // Handle theme change here
                },
              ),
            ),
            ListTile(
              title: Text('Dark Theme'),
              leading: Radio(
                value: 'dark',
                groupValue:
                    'theme', // This should be linked to a state variable
                onChanged: (value) {
                  // Handle theme change here
                },
              ),
            ),

            // Account Settings
            SizedBox(height: 20),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                // Handle privacy policy navigation here
              },
            ),
            ListTile(
              title: Text('Terms of Service'),
              onTap: () {
                // Handle terms of service navigation here
              },
            ),

            // Logout Button
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout functionality
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                          ),
                          TextButton(
                            child: Text("Log Out"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              // Add logout functionality
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login', // Navigate to the login screen
                                (route) => false, // Remove all routes
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Log Out', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}