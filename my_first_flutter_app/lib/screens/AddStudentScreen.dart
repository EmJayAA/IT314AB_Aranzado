import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  final List<String> existingStudentIds;

  const AddStudentScreen({super.key, this.existingStudentIds = const []});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _studentIdController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _courseController = TextEditingController();
  final _yearLevelController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    _fullNameController.dispose();
    _courseController.dispose();
    _yearLevelController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final newStudent = {
        'id': _studentIdController.text.trim(),
        'name': _fullNameController.text.trim(),
        'course': _courseController.text.trim(),
        'year': _yearLevelController.text.trim(),
        'email': _emailController.text.trim(),
      };

      _studentIdController.clear();
      _fullNameController.clear();
      _courseController.clear();
      _yearLevelController.clear();
      _emailController.clear();

      Navigator.pop(context, newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: const Text(
          'Add Student',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Student Enrollment Form',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _studentIdController,
                label: 'Student ID',
                icon: Icons.badge,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Student ID is required.';
                  }
                  if (widget.existingStudentIds.contains(value.trim())) {
                    return 'This Student ID already exists.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full Name is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _courseController,
                label: 'Course',
                icon: Icons.school,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Course is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _yearLevelController,
                label: 'Year Level (1-5)',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Year Level is required.';
                  }
                  final year = int.tryParse(value.trim());
                  if (year == null || year < 1 || year > 5) {
                    return 'Enter a valid year level between 1 and 5.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email Address is required.';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _validateAndSubmit,
                child: const Text(
                  'Submit Enrollment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: const Color(0xFFFFD700)),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFFD700)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFFFD700),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}