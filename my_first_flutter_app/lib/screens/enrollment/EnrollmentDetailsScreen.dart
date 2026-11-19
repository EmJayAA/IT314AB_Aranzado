import 'package:flutter/material.dart';
import '../../models/enrollment_model.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../models/schedule_model.dart';

class EnrollmentDetailsScreen extends StatelessWidget {
  final Enrollment enrollment;
  final List<Student> students;
  final List<Subject> subjects;
  final List<Schedule> schedules;

  const EnrollmentDetailsScreen({
    super.key,
    required this.enrollment,
    required this.students,
    required this.subjects,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    final student = students.firstWhere(
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

    final subject = subjects.firstWhere(
      (s) => s.subjectID == enrollment.subjectID,
      orElse: () => Subject(
        subjectID: 0,
        subjectCode: 'N/A',
        subjectName: 'Unknown Subject',
        units: 0,
        description: 'N/A',
      ),
    );

    final schedule = schedules.firstWhere(
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

    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enrollment Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                side: const BorderSide(color: Color(0xFFFFD700), width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.assignment, size: 50, color: Colors.white54),
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
                      'Subject: ${subject.subjectCode} - ${subject.subjectName}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Schedule: ${schedule.dayOfWeek} (${schedule.startTime} - ${schedule.endTime})',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Room: ${schedule.room}',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${enrollment.status}',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enrolled At: ${enrollment.enrolledAt.toLocal().toString().split('.').first}',
                      style: const TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Enrollment ID: ${enrollment.enrollmentID}',
                      style: const TextStyle(fontSize: 12, color: Colors.white38),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}