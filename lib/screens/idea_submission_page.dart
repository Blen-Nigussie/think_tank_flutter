import 'package:flutter/material.dart';

class IdeaSubmissionPage extends StatefulWidget {
  final VoidCallback onNavigateToIdeas;
  final VoidCallback onBackClick;

  const IdeaSubmissionPage({
    super.key,
    required this.onNavigateToIdeas,
    required this.onBackClick,
  });

  @override
  State<IdeaSubmissionPage> createState() => _IdeaSubmissionPageState();
}

class _IdeaSubmissionPageState extends State<IdeaSubmissionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  bool _isSubmitting = false;
  String? _errorMessage;
  bool _submissionSuccess = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _onSubmitIdea() async {
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _submissionSuccess = false;
    });

    // Basic validation
    if (_titleController.text.length < 3) {
      setState(() {
        _errorMessage = 'Title must be at least 3 characters long.';
        _isSubmitting = false;
      });
      return;
    }
    if (_descriptionController.text.length < 10) {
      setState(() {
        _errorMessage = 'Description must be at least 10 characters long.';
        _isSubmitting = false;
      });
      return;
    }

    // Simulate network submission
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success or failure
    if (_titleController.text == "fail") {
      setState(() {
        _errorMessage = "Simulated submission failure.";
        _isSubmitting = false;
      });
    } else {
      setState(() {
        _submissionSuccess = true;
        _isSubmitting = false;
      });
      // Navigate after a short delay to show success message
      Future.delayed(const Duration(seconds: 1), () {
        widget.onNavigateToIdeas();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color fontColor = Colors.white;
    final Color buttonColor = const Color(0xFFFAA60C);
    final Color backgroundColor = const Color(0xFF1A1A1A);
    final Color errorColor = const Color(0xFFFF5252);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Bar
                  Row(
                    children: [
                      IconButton(
                        icon: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        onPressed: widget.onBackClick,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Submit Your Idea",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Light Bulb Image
                  Image.asset(
                    'lib/assets/bulb_image.png', // Assuming this image exists
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Text(
                            'Image not found',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24), // Spacer

                  // Form Fields
                  Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        onChanged: (text) => setState(() { _errorMessage = null; }),
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF2A2A2A),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: buttonColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            _titleController.text.length < 3 && _titleController.text.isNotEmpty
                                ? "Minimum 3 characters"
                                : "",
                            style: TextStyle(fontSize: 12, color: errorColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        onChanged: (text) => setState(() { _errorMessage = null; }),
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF2A2A2A),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: buttonColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            _descriptionController.text.length < 10 && _descriptionController.text.isNotEmpty
                                ? "Minimum 10 characters"
                                : "",
                            style: TextStyle(fontSize: 12, color: errorColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _tagsController,
                        decoration: InputDecoration(
                          labelText: 'Tags (optional)',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF2A2A2A),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: buttonColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            "Separate tags with commas",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32), // Spacer

                  // Error Message
                  if (_errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: errorColor, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _onSubmitIdea,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Submit Idea",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),

            // Success Overlay
            if (_submissionSuccess)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(32.0),
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50), // Green color for success
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Idea Submitted Successfully!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Redirecting to ideas page...",
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