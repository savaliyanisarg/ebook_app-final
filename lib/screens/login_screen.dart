import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart'; // Import the Signup screen
import 'main_screen.dart'; // Import the Main screen
import 'admin_screen.dart'; // Import the Admin screen if you have one

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  // Regular user login function
  Future<void> _login() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please enter both email and password.';
        });
        return;
      }

      // Attempt to sign in with Firebase Authentication
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Navigate to Main Screen upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (error) {
      setState(() {
        errorMessage = "Login failed: ${error.toString()}";
      });
    }
  }

  // Admin login function with custom credentials
  Future<void> _adminLogin() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please enter both email and password.';
        });
        return;
      }

      // Check if the credentials match the hardcoded admin account
      if (email == 'dsavaliya735@rku.ac.in' && password == '67246724') {
        // Navigate to Admin Screen upon successful admin login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      } else {
        setState(() {
          errorMessage = 'Admin login failed: Invalid credentials.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Admin login failed: ${error.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Trigger the regular login method
                await _login();
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to the Signup screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text("Don't have an account? Sign up"),
            ),
            SizedBox(height: 16),
            // Admin Login Button
            TextButton(
              onPressed: () async {
                // Trigger the admin login method
                await _adminLogin();
              },
              child: Text(
                "Admin Login",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
