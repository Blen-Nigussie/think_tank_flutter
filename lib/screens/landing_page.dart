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
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'lib/assets/landing_page_lightbulb.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Color(0xFF1A1A1A),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.lightbulb_outline,
                        size: 150,
                        color: const Color(0xFFFAA60C).withOpacity(0.3),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Foreground content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Centered Buttons
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 270,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: onNavigateToLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFAA60C),
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
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
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
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
                    ),
                    const SizedBox(height: 64),
                    // Tagline
                    const Text(
                      'ThinkTank Inspire the world!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFAA60C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
