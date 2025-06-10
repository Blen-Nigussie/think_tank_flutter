import 'package:flutter/material.dart';
import 'package:thinktankapp/data/models/idea.dart';
import 'package:thinktankapp/data/models/user.dart';

class EditIdeaPage extends StatefulWidget {
  final String ideaId;
  final VoidCallback onBackClick;

  const EditIdeaPage({
    super.key,
    required this.ideaId,
    required this.onBackClick,
  });

  @override
  State<EditIdeaPage> createState() => _EditIdeaPageState();
}

class _EditIdeaPageState extends State<EditIdeaPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;
  bool _updateSuccess = false;
  Idea? _currentIdea;

  @override
  void initState() {
    super.initState();
    _loadIdea();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _loadIdea() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate API call to fetch idea details
    await Future.delayed(const Duration(seconds: 1));

    // Mock data based on ideaId
    if (widget.ideaId == '1') {
      _currentIdea = Idea(
        id: '1',
        title: 'Initial Project One',
        description: 'This is the initial description for project one. It\'s a really great idea!',
        status: 'Approved',
        user: User(id: 1, firstName: 'John', lastName: 'Doe', email: 'john@example.com'),
      );
    } else if (widget.ideaId == '2') {
      _currentIdea = Idea(
        id: '2',
        title: 'Second Great Idea',
        description: 'Detailed description for the second great idea.',
        status: 'Approved',
        user: User(id: 2, firstName: 'Jane', lastName: 'Smith', email: 'jane@example.com'),
      );
    } else {
      _errorMessage = 'Idea not found.';
    }

    if (_currentIdea != null) {
      _titleController.text = _currentIdea!.title;
      _descriptionController.text = _currentIdea!.description;
      _tagsController.text = _currentIdea!.tags ?? '';
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onUpdateIdea() async {
    setState(() {
      _isUpdating = true;
      _errorMessage = null;
      _updateSuccess = false;
    });

    // Basic validation (can be more comprehensive)
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Title and description cannot be empty.';
        _isUpdating = false;
      });
      return;
    }

    // Simulate network update
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success or failure (e.g., if title is 'fail')
    if (_titleController.text.toLowerCase() == 'fail') {
      setState(() {
        _errorMessage = "Simulated update failure.";
        _isUpdating = false;
      });
    } else {
      setState(() {
        _updateSuccess = true;
        _isUpdating = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Idea updated successfully!')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          widget.onBackClick();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color orange = Color(0xFFFAA60C);
    const Color white = Colors.white;
    const Color backgroundColor = Colors.black;
    const Color greyColor = Colors.grey; // For unfocused borders/labels

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Top Bar
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onBackClick,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Edit Idea",
                        style: TextStyle(
                          color: orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48), // To balance the back button
                    ],
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: orange),
                        )
                      : _errorMessage != null
                          ? Center(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    labelStyle: TextStyle(color: greyColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: orange),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                    ),
                                    floatingLabelStyle: TextStyle(color: orange),
                                    fillColor:  Color(0xFF2A2A2A),
                                    filled: true,
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
                                  style: const TextStyle(color: white),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _descriptionController,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(color: greyColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: orange),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                    ),
                                    floatingLabelStyle: TextStyle(color: orange),
                                    fillColor: Color(0xFF2A2A2A),
                                    filled: true,
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
                                  style: const TextStyle(color: white),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _tagsController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tags (comma-separated)',
                                    labelStyle: TextStyle(color: greyColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: orange),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                    ),
                                    floatingLabelStyle: TextStyle(color: orange),
                                    fillColor:Color(0xFF2A2A2A),
                                    filled: true,
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
                                  style: const TextStyle(color: white),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _isUpdating ? null : _onUpdateIdea,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: orange,
                                    foregroundColor: white,
                                    minimumSize: const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: _isUpdating
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text(
                                          "Update Idea",
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ],
                            ),
                ],
              ),
            ),
            // Success Overlay
            if (_updateSuccess)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha((0.7 * 255).toInt()),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(32.0),
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50), // Green for success
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Idea Updated Successfully!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Redirecting back...",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 