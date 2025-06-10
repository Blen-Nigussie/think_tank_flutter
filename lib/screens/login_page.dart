import 'package:flutter/material.dart';
import 'package:thinktankapp/services/auth_service.dart';
import 'package:thinktankapp/data/models/auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onNavigateToSignup;
  final VoidCallback onLoginSuccess;

  const LoginPage({
    super.key,
    required this.onNavigateToSignup,
    required this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _loginError;
  final AuthService _authService = AuthService(); // Instantiate AuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _loginError = null;
    });

    try {
      final loginRequest = LoginRequest(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final authResponse = await _authService.loginUser(loginRequest);
      await _authService.saveToken(authResponse.accessToken);
      widget.onLoginSuccess();
    } catch (e) {
      setState(() {
        _loginError = e.toString().contains('Failed to login')
            ? e.toString().replaceFirst('Exception: ', '')
            : 'An unexpected error occurred.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/login_page_image.png', // Assuming this image exists
                      width: 550,
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: 550,
                          height: 250,
                          child: Center(
                            child: Text(
                              'Image not found',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Welcome Back To ThinkTank!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Color(0xFFFAA60C)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // Spacer to push content towards center
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email:',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFAA60C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFAA60C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password:',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFAA60C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFFAA60C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  if (_loginError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        _loginError!,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFAA60C),
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: widget.onNavigateToSignup,
                    child: const Text(
                      "Don\'t have an account? Sign up",
                      style: TextStyle(fontSize: 16, color: Color(0xFFFAA60C)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 