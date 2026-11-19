import 'package:flutter/material.dart';
import '../../models/enrollment_model.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../models/schedule_model.dart';
import '../../viewmodels/enrollment_viewmodel.dart';
import '../../viewmodels/student_viewmodel.dart';
import '../../viewmodels/subject_viewmodel.dart';
import '../../viewmodels/schedule_viewmodel.dart';
import 'AddEnrollmentScreen.dart';
import 'EnrollmentDetailsScreen.dart';
import '../app_drawer.dart';

class EnrollmentListScreen extends StatefulWidget {
  const EnrollmentListScreen({super.key, required this.title});

  final String title;

  @override
  State<EnrollmentListScreen> createState() => _EnrollmentListScreenState();
}

class _EnrollmentListScreenState extends State<EnrollmentListScreen> {
  final EnrollmentViewModel _enrollmentViewModel = EnrollmentViewModel();
  final StudentViewModel _studentViewModel = StudentViewModel();
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  final ScheduleViewModel _scheduleViewModel = ScheduleViewModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _enrollmentViewModel.fetchEnrollments(),
      _studentViewModel.fetchStudents(),
      _subjectViewModel.fetchSubjects(),
      _scheduleViewModel.fetchSchedules(),
    ]);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final newEnrollment = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEnrollmentScreen(
                    availableStudents: _studentViewModel.students,
                    availableSubjects: _subjectViewModel.subjects,
                    availableSchedules: _scheduleViewModel.schedules,
                    existingEnrollments: _enrollmentViewModel.enrollments,
                  ),
                ),
              );
              if (newEnrollment != null && newEnrollment is Enrollment) {
                try {
                  await _enrollmentViewModel.addNewEnrollment(
                    newEnrollment,
                    availableSchedules: _scheduleViewModel.schedules,
                  );
                  await _loadData();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString().replaceFirst('Exception: ', '')),
                        backgroundColor: Colors.red[800],
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListenableBuilder(
        listenable: _enrollmentViewModel,
        builder: (context, child) {
          if (_enrollmentViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (_enrollmentViewModel.enrollments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Enrollments Found.',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tap the + button in the top right to enroll a student.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: _enrollmentViewModel.enrollments.length,
            itemBuilder: (context, index) {
              final enrollment = _enrollmentViewModel.enrollments[index];

              final student = _studentViewModel.students.firstWhere(
                (s) => s.studentID == enrollment.studentID,
                orElse: () => Student(
                  studentID: 0,
                  studentNumber: 'N/A',
                  firstName: 'Unknown',
                  lastName: 'Student',
                  email: 'N/A',
                  course: 'N/A',
                  yearLevel: 0,
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
                  description: 'N/A',
                ),
              );

              final schedule = _scheduleViewModel.schedules.firstWhere(
                (s) => s.scheduleID == enrollment.scheduleID,
                orElse: () => Schedule(
                  scheduleID: 0,
                  subjectID: 0,
                  dayOfWeek: 'N/A',
                  startTime: 'N/A',
                  endTime: 'N/A',
                  room: 'N/A',
                  slotCapacity: 0,
                ),
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnrollmentDetailsScreen(
                          enrollment: enrollment,
                          students: _studentViewModel.students,
                          subjects: _subjectViewModel.subjects,
                          schedules: _scheduleViewModel.schedules,
                        ),
                      ),
                    );
                    _loadData();
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFFFFD700), width: 1.5),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.assignment, size: 40, color: Colors.white54),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${student.firstName} ${student.lastName}',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellow),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${subject.subjectCode} - ${subject.subjectName}',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Schedule: ${schedule.dayOfWeek} (${schedule.startTime} - ${schedule.endTime})',
                                style: const TextStyle(fontSize: 16, color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: ${enrollment.status}',
                                style: const TextStyle(fontSize: 14, color: Colors.white54),
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
                              await _enrollmentViewModel.removeEnrollment(enrollment.enrollmentID);
                              _loadData();
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