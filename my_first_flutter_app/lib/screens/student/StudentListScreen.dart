import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/db_connection.dart';
import '../../models/student_model.dart';
import '../../viewmodels/student_viewmodel.dart';
import 'AddStudentScreen.dart';
import 'StudentDetailsScreen.dart';
import '../app_drawer.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key, required this.title});

  final String title;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late final StudentViewModel _studentViewModel;

  @override
  void initState() {
    super.initState();
    _verifyDbConnection();
    // Access the global view model instance from the Provider scope
    _studentViewModel = Provider.of<StudentViewModel>(context, listen: false);
    _studentViewModel.fetchStudents();
  }

  Future<void> _verifyDbConnection() async {
    final isConnected = await DbConnection.testConnection();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isConnected
              ? 'Connected to Neon PostgreSQL database!'
              : 'Database connection failed: ${DbConnection.lastError}',
        ),
        backgroundColor: isConnected ? Colors.green[700] : Colors.red[800],
        duration: const Duration(seconds: 4),
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
              final existingStudentNumbers = _studentViewModel.students
                  .map((s) => s.studentNumber)
                  .where((num) => num.isNotEmpty)
                  .toList();

              final newStudentData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentScreen(
                    existingStudentNumbers: existingStudentNumbers,
                  ),
                ),
              );

              if (newStudentData != null && newStudentData is Student) {
                await _studentViewModel.addNewStudent(newStudentData);
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListenableBuilder(
        listenable: _studentViewModel,
        builder: (context, child) {
          if (_studentViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (_studentViewModel.students.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Student Found.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your student directory is currently empty.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: _studentViewModel.students.length,
            itemBuilder: (context, index) {
              final student = _studentViewModel.students[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetailsScreen(student: student),
                      ),
                    );
                    _studentViewModel.fetchStudents();
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
                                child: Icon(Icons.person, size: 40, color: Colors.white54),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${student.firstName} ${student.lastName}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Colors.yellow,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Course: ${student.course} (Year ${student.yearLevel})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Helvetica',
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Student No: ${student.studentNumber}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Email: ${student.email}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () async {
                              await _studentViewModel.removeStudent(student.studentID);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}