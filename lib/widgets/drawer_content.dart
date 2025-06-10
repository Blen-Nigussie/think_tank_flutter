import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class DrawerContent extends StatelessWidget {
  final Function(String) onNavigate;
  final VoidCallback onDrawerClose;

  const DrawerContent({
    super.key,
    required this.onNavigate,
    required this.onDrawerClose,
  });

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(title: "Dashboard", icon: Icons.home, route: "/dashboard"),
      MenuItem(title: "User Profile", icon: Icons.person, route: "/profile"),
      MenuItem(title: "Idea Submission", icon: Icons.add, route: "/idea_submission"),
      MenuItem(title: "Feedback Pool", icon: Icons.rate_review, route: "/feedback_pool"),
      MenuItem(title: "Logout", icon: Icons.exit_to_app, route: "/logout"),
      MenuItem(title: "Exit", icon: Icons.close, route: "/exit")
    ];

    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Color(0xFFFAA60C),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KellySlab', // Assuming you have this font set up in pubspec.yaml
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(item.icon, color: const Color(0xFFFAA60C)),
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    onDrawerClose();
                    if (item.route == "/exit") {
                      // For exiting the app, we'll just pop until the first route
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else if (item.route == "/logout") {
                      debugPrint('Logout logic here');
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    } else {
                      onNavigate(item.route);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 