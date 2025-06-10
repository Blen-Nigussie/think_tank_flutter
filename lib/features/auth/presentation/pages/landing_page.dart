import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final VoidCallback onNavigateToSignup;
  final VoidCallback onNavigateToLogin;

  const LandingPage({
    super.key,
    required this.onNavigateToSignup,
    required this.onNavigateToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/landing_page_lightbulb.png',
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Buttons Column
                  Column(
                    children: [
                      SizedBox(
                        width: 270,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: onNavigateToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAA60C),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 270,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: onNavigateToSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAA60C),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  // Tagline Text
                  const Text(
                    'ThinkTank Inspire the world!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFAA60C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 