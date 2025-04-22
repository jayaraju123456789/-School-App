import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'package:startup_app/my_routes/My_Routes.dart';

class LoginException implements Exception {
  final String message;
  final String? details;

  LoginException(this.message, {this.details});

  @override
  String toString() => message;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginService _loginService = LoginService();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  String _username = "";
  String _password = "";
  bool _isLoading = false;
  String _errorMessage = '';
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    if (!mounted || !(_formKey.currentState?.validate() ?? false)) return;

    // Prevent multiple login attempts while processing
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      developer.log('Initiating login process',
          name: 'LoginScreen', error: {'username': _username});

      // final response = await _loginService.login(_username, _password);

      // if (!mounted) return;

      // if (response['success'] == true) {
      //   if (response['token'] != null) {
      //     final prefs = await SharedPreferences.getInstance();
      //     await prefs.setString('auth_token', response['token']);

      //     if (mounted) {
      //       Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      //     }
      //   } else {
      //     throw LoginException('Invalid server response: Missing token');
      //   }
      // } else {
      //   // Show more detailed error message
      //   throw LoginException(response['error'] ?? 'Login failed',
      //       details: response['details']);
      // }
      // Simulate successful login
      await Future.delayed(Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'dummy_token');

      if (mounted) {
        Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      }
    }
    // on LoginException catch (e) {
    //   developer.log('Login failed: ${e.toString()}',
    //       name: 'LoginScreen',
    //       error: {'message': e.toString(), 'details': e.details});

    //   if (mounted) {
    //     setState(() {
    //       _errorMessage = e.toString();
    //     });
    //     _showErrorDialog(e);
    //   }
    // }
    catch (e) {
      // developer.log('Unexpected error during login',
      //     name: 'LoginScreen', error: e.toString());

      // if (mounted) {
      //   setState(() {
      //     _errorMessage = 'An unexpected error occurred. Please try again.';
      //   });
      // }
      print(e);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(LoginException error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(error.toString()),
            if (error.details != null) ...[
              const SizedBox(height: 8),
              Text(
                error.details!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB).withAlpha(230),
              Color(0xFF2575FC).withAlpha(230),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Enhanced Logo with 3D effect
                Material(
                  color: Colors.transparent,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.05)
                      ..rotateY(0.05),
                    alignment: FractionalOffset.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/lpu_logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOutBack)
                    .fade(),
                const SizedBox(height: 20),
                // Gradient Text Headers
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFFFA07A), Color(0xFFFFD700)],
                  ).createShader(bounds),
                  child: const Text(
                    'Lovely Professional University',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Transforming Education Transforming India',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Welcome Message
                Text(
                  'Welcome ${_username.isEmpty ? '' : _username}!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Enhanced Login Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    color: Colors.transparent,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(0.02),
                      alignment: FractionalOffset.center,
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(50),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Enter your username',
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) => _username = value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Username cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildPasswordField(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .slideY(duration: 500.ms, curve: Curves.easeOut)
                    .fade(),
                const SizedBox(height: 30),
                // Enhanced Sign In Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    color: Colors.transparent,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(0.02),
                      alignment: FractionalOffset.center,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFA07A), Color(0xFFFFD700)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: _handleLogin,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.white54,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 500.ms, curve: Curves.easeOutBack)
                    .fade(),
                const SizedBox(height: 20),
                // NAAC Grade with Rounded Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/lpu_nacc.jpg',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                // Error Message
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: const OutlineInputBorder(),
      ),
      obscureText: _obscurePassword,
      onChanged: (value) => _password = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password cannot be empty";
        }
        return null;
      },
    );
  }
}
