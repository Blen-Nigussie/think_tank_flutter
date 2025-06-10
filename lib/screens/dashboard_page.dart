import 'package:flutter/material.dart';
import 'package:thinktankapp/data/models/idea.dart';
import 'package:thinktankapp/data/models/user.dart';
import 'package:thinktankapp/widgets/drawer_content.dart';
import 'package:thinktankapp/widgets/project_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  String? _error;
  List<Idea> _approvedIdeas = [];

  @override
  void initState() {
    super.initState();
    _loadApprovedIdeas();
  }

  void _loadApprovedIdeas() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock data for demonstration
    final mockIdeas = ['1', '2', '3', '4', '5', '6', '7', '8'].map((id) => Idea(
      id: id,
      title: 'Project $id',
      description: 'This is a description for Project $id, showcasing an innovative idea.',
      status: 'Approved',
      user: User(id: int.parse(id), firstName: 'User', lastName: id, email: 'user$id@example.com'),
    )).toList();

    setState(() {
      _approvedIdeas = mockIdeas;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Center(
          child: Text(
            "ThinkTank",
            style: TextStyle(
              color: Color(0xFFFAA60C),
              fontSize: 28,
              fontFamily: 'KellySlab', // Ensure this font is in pubspec.yaml
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFAA60C).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu, color: Colors.white),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: DrawerContent(
        onNavigate: (route) {
          Navigator.pop(context); // Close the drawer
          if (route == "/exit") {
            Navigator.of(context).popUntil((r) => r.isFirst);
          } else if (route == "/logout") {
            Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
          } else {
            Navigator.pushNamed(context, route);
          }
        },
        onDrawerClose: () {
          Navigator.pop(context); // Close the drawer
        },
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFAA60C)),
              ),
            )
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadApprovedIdeas,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFFFAA60C).withOpacity(0.1),
                        ),
                        child: Image.asset(
                          'lib/assets/dashboard_bulb.png', // Assuming this image exists
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                'Image not found',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Approved Ideas",
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'KellySlab',
                              color: Color(0xFFFAA60C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_approvedIdeas.length} Ideas',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: _approvedIdeas.isEmpty
                          ? const Center(
                              child: Text(
                                "No approved ideas yet",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 1.0, // Adjust as needed
                              ),
                              itemCount: _approvedIdeas.length,
                              itemBuilder: (context, index) {
                                final idea = _approvedIdeas[index];
                                return ProjectCard(
                                  idea: idea,
                                  onClick: () {
                                    debugPrint('Clicked idea: ${idea.title}');
                                    // TODO: Implement navigation to idea detail page
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