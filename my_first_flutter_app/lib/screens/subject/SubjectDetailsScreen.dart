import 'package:flutter/material.dart';
import '../../models/subject_model.dart';
import '../../viewmodels/subject_viewmodel.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final Subject subject;
  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  late Subject _currentSubject;

  @override
  void initState() {
    super.initState();
    _currentSubject = widget.subject;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Subject Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: Color(0xFFFFD700),
                  width: 1.5,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.book, size: 50, color: Colors.white54),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _currentSubject.subjectName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Subject Code: ${_currentSubject.subjectCode}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Subject ID: ${_currentSubject.subjectID}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Units: ${_currentSubject.units}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description: ${_currentSubject.description}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        final codeController = TextEditingController(text: _currentSubject.subjectCode);
                        final nameController = TextEditingController(text: _currentSubject.subjectName);
                        final unitsController = TextEditingController(text: _currentSubject.units.toString());
                        final descriptionController = TextEditingController(text: _currentSubject.description);

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext modalContext) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: MediaQuery.of(modalContext).viewInsets.bottom + 20.0,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Edit Subject Details',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextField(
                                      controller: codeController,
                                      decoration: const InputDecoration(
                                        labelText: 'Subject Code',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Subject Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: unitsController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Units (1-5)',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                        labelText: 'Description',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFD700),
                                        foregroundColor: Colors.black,
                                      ),
                                      onPressed: () async {
                                        final updatedSubject = Subject(
                                          subjectID: _currentSubject.subjectID,
                                          subjectCode: codeController.text.trim(),
                                          subjectName: nameController.text.trim(),
                                          units: int.tryParse(unitsController.text.trim()) ?? _currentSubject.units,
                                          description: descriptionController.text.trim(),
                                        );

                                        await _subjectViewModel.editSubject(updatedSubject);

                                        setState(() {
                                          _currentSubject = updatedSubject;
                                        });

                                        if (context.mounted) {
                                          Navigator.pop(modalContext);
                                        }
                                      },
                                      child: const Text('Save Changes'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
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