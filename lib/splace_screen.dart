import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'features/dashboard/dashboard_screen.dart'; // Update import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // This function will wait for 3 seconds before transitioning to the home screen.
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color of the Splash Screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_ZzyTyd.json',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the School App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
