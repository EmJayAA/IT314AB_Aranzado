import 'package:flutter/material.dart';
import '../../models/grade_model.dart';
import '../../models/enrollment_model.dart';
import '../../models/subject_model.dart';
import '../../models/student_model.dart';

class AddGradeScreen extends StatefulWidget {
  final int? initialStudentID;
  final List<Student> students;
  final List<Enrollment> enrollments;
  final List<Subject> subjects;
  final Grade? existingGrade;

  const AddGradeScreen({
    super.key,
    this.initialStudentID,
    required this.students,
    required this.enrollments,
    required this.subjects,
    this.existingGrade,
  });

  @override
  State<AddGradeScreen> createState() => _AddGradeScreenState();
}

class _AddGradeScreenState extends State<AddGradeScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedStudentID;
  int? _selectedEnrollmentID;
  late TextEditingController _gradeController;
  late TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    if (widget.existingGrade != null) {
      _selectedEnrollmentID = widget.existingGrade!.enrollmentID;
      final match = widget.enrollments.firstWhere(
        (e) => e.enrollmentID == _selectedEnrollmentID,
        orElse: () => Enrollment(
          enrollmentID: 0,
          studentID: 0,
          subjectID: 0,
          scheduleID: 0,
          enrolledAt: DateTime.now(),
          status: '',
        ),
      );
      _selectedStudentID =
          match.studentID != 0 ? match.studentID : widget.initialStudentID;
    } else {
      _selectedStudentID = widget.initialStudentID ??
          (widget.students.isNotEmpty ? widget.students.first.studentID : null);
    }

    _gradeController = TextEditingController(
      text: widget.existingGrade?.gradeValue.toString() ?? '',
    );
    _remarksController = TextEditingController(
      text: widget.existingGrade?.remarks ?? '',
    );
  }

  @override
  void dispose() {
    _gradeController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedEnrollmentID != null) {
      final gradeValue = double.tryParse(_gradeController.text.trim());
      if (gradeValue == null) return;

      final grade = Grade(
        gradeID: widget.existingGrade?.gradeID ??
            DateTime.now().millisecondsSinceEpoch,
        enrollmentID: _selectedEnrollmentID!,
        gradeValue: gradeValue,
        remarks: _remarksController.text.trim().isEmpty
            ? null
            : _remarksController.text.trim(),
        dateRecorded: widget.existingGrade?.dateRecorded ?? DateTime.now(),
      );

      Navigator.pop(context, grade);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentEnrollments = widget.enrollments
        .where((e) =>
            e.studentID == _selectedStudentID &&
            e.status.trim().toLowerCase() == 'enrolled')
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          widget.existingGrade == null ? 'Add Student Grade' : 'Edit Student Grade',
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
              const Text(
                'Grade Entry Form',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<int>(
                initialValue: _selectedStudentID,
                dropdownColor: const Color(0xFF5A0000),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Select Student',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.person, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: widget.students.map((student) {
                  return DropdownMenuItem<int>(
                    value: student.studentID,
                    child: Text(
                      '${student.firstName} ${student.lastName} (${student.studentNumber})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: widget.existingGrade == null
                    ? (val) {
                        setState(() {
                          _selectedStudentID = val;
                          _selectedEnrollmentID = null;
                        });
                      }
                    : null,
                validator: (val) => val == null ? 'Please select a student.' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                key: ValueKey(_selectedStudentID),
                initialValue: _selectedEnrollmentID,
                dropdownColor: const Color(0xFF5A0000),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: studentEnrollments.isEmpty
                      ? 'No Enrolled Subjects for Student'
                      : 'Select Enrolled Subject',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.book, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: studentEnrollments.map((enrollment) {
                  final subject = widget.subjects.firstWhere(
                    (s) => s.subjectID == enrollment.subjectID,
                    orElse: () => Subject(
                      subjectID: 0,
                      subjectCode: 'N/A',
                      subjectName: 'Unknown',
                      units: 0,
                      description: '',
                    ),
                  );
                  return DropdownMenuItem<int>(
                    value: enrollment.enrollmentID,
                    child: Text(
                      '${subject.subjectCode} - ${subject.subjectName}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: widget.existingGrade == null && studentEnrollments.isNotEmpty
                    ? (val) => setState(() => _selectedEnrollmentID = val)
                    : null,
                validator: (val) =>
                    val == null ? 'Please select an enrolled subject.' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _gradeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Grade Value (e.g. 1.00 - 5.00)',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.grade, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a grade.';
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _remarksController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Remarks (Optional, e.g. Passed / Failed)',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.comment, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _submit,
                child: Text(
                  widget.existingGrade == null ? 'Save Grade' : 'Update Grade',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}