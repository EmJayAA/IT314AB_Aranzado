import 'package:flutter/material.dart';
import '../../models/grade_model.dart';
import '../../models/enrollment_model.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../viewmodels/grade_viewmodel.dart';
import '../../viewmodels/enrollment_viewmodel.dart';
import '../../viewmodels/student_viewmodel.dart';
import '../../viewmodels/subject_viewmodel.dart';
import '../app_drawer.dart';
import 'AddGradeScreen.dart';
import 'GradeDetailsScreen.dart';

class GradeListScreen extends StatefulWidget {
  const GradeListScreen({super.key, required this.title});
  final String title;

  @override
  State<GradeListScreen> createState() => _GradeListScreenState();
}

class _GradeListScreenState extends State<GradeListScreen> {
  final GradeViewModel _gradeViewModel = GradeViewModel();
  final EnrollmentViewModel _enrollmentViewModel = EnrollmentViewModel();
  final StudentViewModel _studentViewModel = StudentViewModel();
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    await Future.wait([
      _gradeViewModel.fetchGrades(),
      _enrollmentViewModel.fetchEnrollments(),
      _studentViewModel.fetchStudents(),
      _subjectViewModel.fetchSubjects(),
    ]);
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              if (_studentViewModel.students.isEmpty ||
                  _enrollmentViewModel.enrollments.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please ensure students and enrollments exist first.'),
                  ),
                );
                return;
              }
              final newGrade = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddGradeScreen(
                    students: _studentViewModel.students,
                    enrollments: _enrollmentViewModel.enrollments,
                    subjects: _subjectViewModel.subjects,
                  ),
                ),
              );
              if (newGrade != null && newGrade is Grade) {
                try {
                  await _gradeViewModel.addNewGrade(newGrade);
                  await _loadData();
                } catch (e) {
                  _showErrorSnackBar(
                    e.toString().replaceFirst('Exception: ', ''),
                  );
                }
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _gradeViewModel.grades.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Grades Found.',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your grade records are currently empty.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica',
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: _gradeViewModel.grades.length,
                  itemBuilder: (context, index) {
                    final grade = _gradeViewModel.grades[index];
                    final enrollment = _enrollmentViewModel.enrollments.firstWhere(
                      (e) => e.enrollmentID == grade.enrollmentID,
                      orElse: () => Enrollment(
                        enrollmentID: 0,
                        studentID: 0,
                        subjectID: 0,
                        scheduleID: 0,
                        enrolledAt: DateTime.now(),
                        status: '',
                      ),
                    );
                    final student = _studentViewModel.students.firstWhere(
                      (s) => s.studentID == enrollment.studentID,
                      orElse: () => Student(
                        studentID: 0,
                        studentNumber: '',
                        firstName: 'Unknown',
                        lastName: 'Student',
                        email: '',
                        course: '',
                        yearLevel: 1,
                        createdAt: DateTime.now(),
                      ),
                    );
                    final subject = _subjectViewModel.subjects.firstWhere(
                      (s) => s.subjectID == enrollment.subjectID,
                      orElse: () => Subject(
                        subjectID: 0,
                        subjectCode: 'N/A',
                        subjectName: 'Unknown Subject',
                        units: 0,
                        description: '',
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GradeDetailsScreen(
                                grade: grade,
                                student: student,
                                subject: subject,
                                enrollments: _enrollmentViewModel.enrollments,
                                subjects: _subjectViewModel.subjects,
                              ),
                            ),
                          );
                          await _loadData();
                        },
                        child: Card(
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
                                      radius: 40,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.grade,
                                          size: 40, color: Colors.white54),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      '${student.firstName} ${student.lastName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Subject: ${subject.subjectCode} - ${subject.subjectName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Grade: ${grade.gradeValue.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (grade.remarks != null) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Remarks: ${grade.remarks}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () async {
                                    try {
                                      await _gradeViewModel
                                          .removeGrade(grade.gradeID);
                                      await _loadData();
                                    } catch (e) {
                                      _showErrorSnackBar(
                                        e
                                            .toString()
                                            .replaceFirst('Exception: ', ''),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}