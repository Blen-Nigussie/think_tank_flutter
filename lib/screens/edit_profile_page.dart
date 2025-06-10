import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final VoidCallback onBackClick;

  const EditProfilePage({
    super.key,
    required this.onBackClick,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _saveSuccess = false;

  // For demonstration, you might initialize these from a user model
  @override
  void initState() {
    super.initState();
    _firstNameController.text = "John"; // Mock data
    _lastNameController.text = "Doe"; // Mock data
    _emailController.text = "john.doe@example.com"; // Mock data
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSaveChanges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _saveSuccess = false;
    });

    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    // Basic validation (example: email format)
    if (!_emailController.text.contains('@')) {
      setState(() {
        _errorMessage = 'Invalid email format.';
        _isLoading = false;
      });
      return;
    }

    // Simulate success/failure based on some condition (e.g., if first name is 'fail')
    if (_firstNameController.text.toLowerCase() == 'fail') {
      setState(() {
        _errorMessage = 'Simulated save failure.';
        _isLoading = false;
      });
    } else {
      setState(() {
        _saveSuccess = true;
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      // Navigate back after a short delay to allow SnackBar to show
      Future.delayed(const Duration(seconds: 1), () {
        widget.onBackClick();
      });
    }
  }

  void _onImageSelect() {
    // TODO: Implement actual image picking using image_picker package
    // For now, this is just a placeholder.
    debugPrint('Image selection triggered');
  }

  @override
  Widget build(BuildContext context) {
    final Color orange = const Color(0xFFFAA60C);
    final Color white = Colors.white;
    final Color backgroundColor = Colors.black;
    final Color errorColor = Colors.red;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onBackClick,
                    icon: Icon(
                      Icons.arrow_back,
                      color: white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 24,
                      color: orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // To balance the back button
                ],
              ),
              const SizedBox(height: 24),

              // Profile Picture
              GestureDetector(
                onTap: _onImageSelect,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: orange, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('lib/assets/user_profile_icon.png'), // Placeholder image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: orange, width: 1),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: orange,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  floatingLabelStyle: TextStyle(color: orange),
                ),
                style: TextStyle(color: white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  floatingLabelStyle: TextStyle(color: orange),
                ),
                style: TextStyle(color: white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: orange),
                  ),
                  floatingLabelStyle: TextStyle(color: orange),
                ),
                style: TextStyle(color: white),
              ),
              const SizedBox(height: 24),

              // Error Message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: errorColor, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _onSaveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor: white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 