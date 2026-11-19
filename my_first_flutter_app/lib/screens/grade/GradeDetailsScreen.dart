import 'package:flutter/material.dart';
import '../../models/grade_model.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../models/enrollment_model.dart';
import '../../viewmodels/grade_viewmodel.dart';

class GradeDetailsScreen extends StatefulWidget {
  final Grade grade;
  final Student student;
  final Subject subject;
  final List<Enrollment> enrollments;
  final List<Subject> subjects;

  const GradeDetailsScreen({
    super.key,
    required this.grade,
    required this.student,
    required this.subject,
    required this.enrollments,
    required this.subjects,
  });

  @override
  State<GradeDetailsScreen> createState() => _GradeDetailsScreenState();
}

class _GradeDetailsScreenState extends State<GradeDetailsScreen> {
  final GradeViewModel _gradeViewModel = GradeViewModel();
  late Grade _currentGrade;

  @override
  void initState() {
    super.initState();
    _currentGrade = widget.grade;
  }

  void _showEditModal() {
    final formKey = GlobalKey<FormState>();
    final gradeController =
        TextEditingController(text: _currentGrade.gradeValue.toString());
    final remarksController =
        TextEditingController(text: _currentGrade.remarks ?? '');
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext sheetContext, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Edit Grade Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: gradeController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Grade Value (1.00 - 5.00)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter a grade value.';
                          }
                          final parsed = double.tryParse(val.trim());
                          if (parsed == null) {
                            return 'Please enter a valid number.';
                          }
                          if (parsed < 1.0 || parsed > 5.0) {
                            return 'Grade must be between 1.00 and 5.00.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: remarksController,
                        decoration: const InputDecoration(
                          labelText: 'Remarks',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD700),
                          foregroundColor: Colors.black,
                        ),
                        onPressed: isSaving
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;

                                final parsedValue =
                                    double.tryParse(gradeController.text.trim());
                                if (parsedValue == null) return;

                                setModalState(() => isSaving = true);

                                final updatedGrade = Grade(
                                  gradeID: _currentGrade.gradeID,
                                  enrollmentID: _currentGrade.enrollmentID,
                                  gradeValue: parsedValue,
                                  remarks: remarksController.text.trim().isEmpty
                                      ? null
                                      : remarksController.text.trim(),
                                  dateRecorded: DateTime.now(),
                                );

                                try {
                                  await _gradeViewModel
                                      .editGrade(updatedGrade);

                                  if (mounted) {
                                    setState(() {
                                      _currentGrade = updatedGrade;
                                    });
                                  }

                                  if (sheetContext.mounted) {
                                    Navigator.pop(sheetContext);
                                  }
                                } catch (e) {
                                  setModalState(() => isSaving = false);
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to update grade: ${e.toString().replaceFirst('Exception: ', '')}',
                                        ),
                                        backgroundColor: Colors.red[800],
                                      ),
                                    );
                                  }
                                }
                              },
                        child: Text(isSaving ? 'Saving...' : 'Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      gradeController.dispose();
      remarksController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Grade Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFFFD700), width: 1.5),
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
                      child: Icon(Icons.grade, size: 50, color: Colors.white54),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${widget.student.firstName} ${widget.student.lastName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Subject: ${widget.subject.subjectCode} - ${widget.subject.subjectName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Grade Value: ${_currentGrade.gradeValue.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Remarks: ${_currentGrade.remarks ?? 'N/A'}',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Grade ID: ${_currentGrade.gradeID} | Enrollment ID: ${_currentGrade.enrollmentID}',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date Recorded: ${_currentGrade.dateRecorded.toLocal().toString().split('.')[0]}',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: _showEditModal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}