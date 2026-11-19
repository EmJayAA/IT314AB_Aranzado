import 'package:flutter/material.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../models/schedule_model.dart';
import '../../models/enrollment_model.dart';
import '../../viewmodels/student_viewmodel.dart';
import '../../viewmodels/enrollment_viewmodel.dart';
import '../../viewmodels/subject_viewmodel.dart';
import '../../viewmodels/schedule_viewmodel.dart';
import '../../viewmodels/grade_viewmodel.dart';

class StudentDetailsScreen extends StatefulWidget {
  final Student student;
  const StudentDetailsScreen({super.key, required this.student});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final StudentViewModel _studentViewModel = StudentViewModel();
  final EnrollmentViewModel _enrollmentViewModel = EnrollmentViewModel();
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  final ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  final GradeViewModel _gradeViewModel = GradeViewModel();

  late Student _currentStudent;
  bool _isLoadingData = true;

  @override
  void initState() {
    super.initState();
    _currentStudent = widget.student;
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await Future.wait([
      _enrollmentViewModel.fetchEnrollments(),
      _subjectViewModel.fetchSubjects(),
      _scheduleViewModel.fetchSchedules(),
      _gradeViewModel.fetchGrades(),
    ]);
    if (mounted) {
      setState(() {
        _isLoadingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentEnrollments = _enrollmentViewModel.enrollments
        .where((e) => e.studentID == _currentStudent.studentID && e.status == 'Enrolled')
        .toList();

    final studentEnrollmentIDs = studentEnrollments.map((e) => e.enrollmentID).toSet();
    final studentGrades = _gradeViewModel.grades
        .where((g) => studentEnrollmentIDs.contains(g.enrollmentID))
        .toList();

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
          'Student Details',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: Icon(Icons.person, size: 50, color: Colors.white54),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${_currentStudent.firstName} ${_currentStudent.lastName}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Course: ${_currentStudent.course} (Year ${_currentStudent.yearLevel})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Student ID: ${_currentStudent.studentID}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Student Number: ${_currentStudent.studentNumber}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email: ${_currentStudent.email}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Contact No.: ${_currentStudent.contactNumber ?? 'N/A'}',
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Created At: ${_currentStudent.createdAt.toLocal().toString().split('.')[0]}',
                          style: const TextStyle(fontSize: 14, color: Colors.white54),
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
                        final firstNameController = TextEditingController(text: _currentStudent.firstName);
                        final lastNameController = TextEditingController(text: _currentStudent.lastName);
                        final courseController = TextEditingController(text: _currentStudent.course);
                        final yearController = TextEditingController(text: _currentStudent.yearLevel.toString());
                        final emailController = TextEditingController(text: _currentStudent.email);
                        final phoneController = TextEditingController(text: _currentStudent.contactNumber ?? '');

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
                                      'Edit Student Details',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextField(
                                      controller: firstNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'First Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: lastNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Last Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: courseController,
                                      decoration: const InputDecoration(
                                        labelText: 'Course',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: yearController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Year Level',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: phoneController,
                                      decoration: const InputDecoration(
                                        labelText: 'Contact No.',
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
                                        final updatedStudent = Student(
                                          studentID: _currentStudent.studentID,
                                          studentNumber: _currentStudent.studentNumber,
                                          firstName: firstNameController.text.trim(),
                                          lastName: lastNameController.text.trim(),
                                          email: emailController.text.trim(),
                                          course: courseController.text.trim(),
                                          yearLevel: int.tryParse(yearController.text.trim()) ?? _currentStudent.yearLevel,
                                          contactNumber: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
                                          createdAt: _currentStudent.createdAt,
                                        );

                                        await _studentViewModel.editStudent(updatedStudent);

                                        setState(() {
                                          _currentStudent = updatedStudent;
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
            const SizedBox(height: 25),
            const Text(
              'Enrolled Subjects',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 15),
            _isLoadingData
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : studentEnrollments.isEmpty
                    ? const Text(
                        'No active enrollments for this student.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: studentEnrollments.length,
                        itemBuilder: (context, index) {
                          final enrollment = studentEnrollments[index];
                          final subject = _subjectViewModel.subjects.firstWhere(
                            (s) => s.subjectID == enrollment.subjectID,
                            orElse: () => Subject(subjectID: 0, subjectCode: 'N/A', subjectName: 'Unknown', units: 0, description: ''),
                          );
                          final schedule = _scheduleViewModel.schedules.firstWhere(
                            (s) => s.scheduleID == enrollment.scheduleID,
                            orElse: () => Schedule(scheduleID: 0, subjectID: 0, dayOfWeek: 'N/A', startTime: 'N/A', endTime: 'N/A', room: 'N/A', slotCapacity: 0),
                          );

                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.white24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${subject.subjectCode} - ${subject.subjectName}',
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Schedule: ${schedule.dayOfWeek} (${schedule.startTime} - ${schedule.endTime})',
                                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                                  ),
                                  Text(
                                    'Room: ${schedule.room} | Units: ${subject.units}',
                                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            const SizedBox(height: 25),
            const Text(
              'Student Grades',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 15),
            studentGrades.isEmpty
                ? const Text(
                    'No grades recorded yet.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: studentGrades.length,
                    itemBuilder: (context, index) {
                      final grade = studentGrades[index];
                      final enrollment = _enrollmentViewModel.enrollments.firstWhere(
                        (e) => e.enrollmentID == grade.enrollmentID,
                        orElse: () => Enrollment(enrollmentID: 0, studentID: 0, subjectID: 0, scheduleID: 0, enrolledAt: DateTime.now(), status: ''),
                      );
                      final subject = _subjectViewModel.subjects.firstWhere(
                        (s) => s.subjectID == enrollment.subjectID,
                        orElse: () => Subject(subjectID: 0, subjectCode: 'N/A', subjectName: 'Unknown', units: 0, description: ''),
                      );

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Color(0xFFFFD700), width: 1),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          title: Text(
                            '${subject.subjectCode} - ${subject.subjectName}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                'Grade: ${grade.gradeValue.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              if (grade.remarks != null)
                                Text(
                                  'Remarks: ${grade.remarks}',
                                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                                ),
                              Text(
                                'Recorded: ${grade.dateRecorded.toLocal().toString().split('.').first}',
                                style: const TextStyle(fontSize: 12, color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}