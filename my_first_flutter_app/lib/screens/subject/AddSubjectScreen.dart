import 'package:flutter/material.dart';
import '../../models/subject_model.dart';

class AddSubjectScreen extends StatefulWidget {
  final List<String> existingSubjectCodes;
  final Subject? subjectToEdit;

  const AddSubjectScreen({
    super.key,
    this.existingSubjectCodes = const [],
    this.subjectToEdit,
  });

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _subjectCodeController;
  late final TextEditingController _subjectNameController;
  late final TextEditingController _unitsController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _subjectCodeController = TextEditingController(text: widget.subjectToEdit?.subjectCode ?? '');
    _subjectNameController = TextEditingController(text: widget.subjectToEdit?.subjectName ?? '');
    _unitsController = TextEditingController(text: widget.subjectToEdit?.units.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.subjectToEdit?.description ?? '');
  }

  @override
  void dispose() {
    _subjectCodeController.dispose();
    _subjectNameController.dispose();
    _unitsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final updatedSubject = Subject(
        subjectID: widget.subjectToEdit?.subjectID ?? DateTime.now().millisecondsSinceEpoch,
        subjectCode: _subjectCodeController.text.trim(),
        subjectName: _subjectNameController.text.trim(),
        units: int.parse(_unitsController.text.trim()),
        description: _descriptionController.text.trim(),
      );

      Navigator.pop(context, updatedSubject);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.subjectToEdit != null;

    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          isEditing ? 'Edit Subject' : 'Add Subject',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              Text(
                isEditing ? 'Update Subject Information' : 'Subject Enrollment Form',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _subjectCodeController,
                label: 'Subject Code',
                icon: Icons.code,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Subject Code is required.';
                  }
                  final trimmedValue = value.trim();
                  if (trimmedValue != widget.subjectToEdit?.subjectCode &&
                      widget.existingSubjectCodes.contains(trimmedValue)) {
                    return 'This Subject Code already exists.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _subjectNameController,
                label: 'Subject Name',
                icon: Icons.subject,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Subject Name is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _unitsController,
                label: 'Units (1-5)',
                icon: Icons.looks_one,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Units are required.';
                  }
                  final units = int.tryParse(value.trim());
                  if (units == null || units < 1 || units > 5) {
                    return 'Enter valid units between 1 and 5.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required.';
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
                child: Text(
                  isEditing ? 'Save Changes' : 'Submit Subject',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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