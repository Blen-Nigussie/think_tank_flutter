import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/idea_submission_page.dart';
import 'screens/edit_profile_page.dart';
import 'screens/idea_pool_list_screen.dart';
import 'data/models/idea.dart';
import 'data/models/user.dart';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThinkTank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFAA60C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPageWrapper(),
        '/login': (context) => LoginPage(
              onNavigateToSignup: () => Navigator.pushNamed(context, '/register'),
              onLoginSuccess: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
        '/register': (context) => RegisterPage(
              onNavigateToLogin: () => Navigator.pushNamed(context, '/login'),
              onNavigateToHome: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
        '/dashboard': (context) => const DashboardPage(),
        '/profile': (context) => EditProfilePage(
              onBackClick: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
        '/idea_submission': (context) => IdeaSubmissionPage(
              onNavigateToIdeas: () => Navigator.pushReplacementNamed(context, '/dashboard'),
              onBackClick: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
        '/idea_pool': (context) => IdeaPoolListScreen(
              ideas: [
                Idea(
                  id: '4',
                  title: 'Add Push Notifications',
                  description: 'Implement push notifications for important updates and idea status changes.',
                  status: 'Pending',
                  user: User(id: 4, firstName: 'David', lastName: 'Wilson', email: 'david@example.com'),
                ),
                Idea(
                  id: '5',
                  title: 'Offline Mode',
                  description: 'Allow users to view and submit ideas while offline.',
                  status: 'Pending',
                  user: User(id: 5, firstName: 'Eva', lastName: 'Brown', email: 'eva@example.com'),
                ),
              ],
              onReviewIdea: (idea) {
                // This navigation will no longer go to a feedback screen
                // You will need to decide where to navigate or what action to take
                log('Review idea: ${idea.title}');
              },
              onViewReviewedIdeas: () {
                // This navigation will no longer go to a feedback pool screen
                // You will need to decide where to navigate or what action to take
                // when viewing reviewed ideas.
                log('View reviewed ideas');
              },
              onBack: () => Navigator.pop(context),
            ),
      },
    );
  }
}

class LandingPageWrapper extends StatelessWidget {
  const LandingPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPage(
      onNavigateToLogin: () {
        Navigator.pushNamed(context, '/login');
      },
      onNavigateToSignup: () {
        Navigator.pushNamed(context, '/register');
      },
    );
  }
}
