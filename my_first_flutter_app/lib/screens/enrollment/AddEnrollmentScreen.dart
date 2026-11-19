import 'package:flutter/material.dart';
import '../../models/enrollment_model.dart';
import '../../models/student_model.dart';
import '../../models/subject_model.dart';
import '../../models/schedule_model.dart';

class AddEnrollmentScreen extends StatefulWidget {
  final List<Student> availableStudents;
  final List<Subject> availableSubjects;
  final List<Schedule> availableSchedules;
  final List<Enrollment> existingEnrollments;

  const AddEnrollmentScreen({
    super.key,
    required this.availableStudents,
    required this.availableSubjects,
    required this.availableSchedules,
    required this.existingEnrollments,
  });

  @override
  State<AddEnrollmentScreen> createState() => _AddEnrollmentScreenState();
}

class _AddEnrollmentScreenState extends State<AddEnrollmentScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedStudentID;
  int? _selectedSubjectID;
  int? _selectedScheduleID;
  bool _isSubmitting = false;

  bool _isActiveEnrolled(Enrollment e) =>
      e.status.trim().toLowerCase() == 'enrolled';

  void _submit() {
    if (_isSubmitting) return;

    if (_formKey.currentState!.validate() &&
        _selectedStudentID != null &&
        _selectedSubjectID != null &&
        _selectedScheduleID != null) {
      final bool alreadyEnrolled = widget.existingEnrollments.any((e) =>
          e.studentID == _selectedStudentID &&
          e.subjectID == _selectedSubjectID &&
          _isActiveEnrolled(e));

      if (alreadyEnrolled) {
        _showErrorDialog(
          'Validation Error',
          'This student is already enrolled in this subject.',
        );
        return;
      }

      final selectedSchedule = widget.availableSchedules.firstWhere(
        (s) => s.scheduleID == _selectedScheduleID,
        orElse: () => Schedule(
          scheduleID: 0,
          subjectID: 0,
          dayOfWeek: '',
          startTime: '',
          endTime: '',
          room: '',
          slotCapacity: 0,
        ),
      );

      if (selectedSchedule.scheduleID == 0) {
        _showErrorDialog(
          'Invalid Schedule',
          'The selected schedule could not be found.',
        );
        return;
      }

      final studentActiveEnrollments = widget.existingEnrollments
          .where((e) => e.studentID == _selectedStudentID && _isActiveEnrolled(e))
          .toList();

      for (final existingEnr in studentActiveEnrollments) {
        final existingSched = widget.availableSchedules.firstWhere(
          (s) => s.scheduleID == existingEnr.scheduleID,
          orElse: () => Schedule(
            scheduleID: 0,
            subjectID: 0,
            dayOfWeek: '',
            startTime: '',
            endTime: '',
            room: '',
            slotCapacity: 0,
          ),
        );

        if (existingSched.scheduleID == 0) continue;

        if (existingSched.dayOfWeek.trim().toLowerCase() ==
            selectedSchedule.dayOfWeek.trim().toLowerCase()) {
          if (_timeOverlap(
            existingSched.startTime,
            existingSched.endTime,
            selectedSchedule.startTime,
            selectedSchedule.endTime,
          )) {
            _showErrorDialog(
              'Schedule Conflict',
              'This student already has a class scheduled at this day and time (${existingSched.dayOfWeek} ${existingSched.startTime}-${existingSched.endTime}).',
            );
            return;
          }
        }
      }

      final int currentEnrolledCount = widget.existingEnrollments
          .where((e) => e.scheduleID == _selectedScheduleID && _isActiveEnrolled(e))
          .length;

      if (currentEnrolledCount >= selectedSchedule.slotCapacity) {
        _showErrorDialog(
          'Slot Full',
          'This schedule has reached its maximum slot capacity (${selectedSchedule.slotCapacity}).',
        );
        return;
      }

      setState(() => _isSubmitting = true);

      final newEnrollment = Enrollment(
        enrollmentID: DateTime.now().millisecondsSinceEpoch,
        studentID: _selectedStudentID!,
        subjectID: _selectedSubjectID!,
        scheduleID: _selectedScheduleID!,
        enrolledAt: DateTime.now(),
        status: 'Enrolled',
      );

      Navigator.pop(context, newEnrollment);
    }
  }

  bool _timeOverlap(String start1, String end1, String start2, String end2) {
    int? parseTime(String t) {
      try {
        String cleaned = t.replaceAll(RegExp(r'Time\(|\)'), '').trim();
        if (cleaned.contains('.')) {
          cleaned = cleaned.split('.').first.trim();
        }

        final upper = cleaned.toUpperCase();
        final isPm = upper.endsWith('PM');
        final isAm = upper.endsWith('AM');

        final timeOnly = cleaned.replaceAll(RegExp(r'(?i)\s*(AM|PM)'), '').trim();
        final parts = timeOnly.split(':');
        if (parts.length < 2) return null;

        int hours = int.parse(parts[0].trim());
        int minutes = int.parse(parts[1].trim());
        if (minutes < 0 || minutes > 59) return null;

        if (isPm || isAm) {
          if (hours < 1 || hours > 12) return null;
          if (isPm && hours < 12) hours += 12;
          if (isAm && hours == 12) hours = 0;
        } else {
          if (hours < 0 || hours > 23) return null;
        }

        return (hours * 60) + minutes;
      } catch (_) {
        return null;
      }
    }

    final int? s1 = parseTime(start1);
    final int? e1 = parseTime(end1);
    final int? s2 = parseTime(start2);
    final int? e2 = parseTime(end2);

    if (s1 == null || e1 == null || s2 == null || e2 == null) return false;

    return s1 < e2 && s2 < e1;
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(title, style: const TextStyle(color: Color(0xFFFFD700))),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: const TextStyle(color: Color(0xFFFFD700))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredSchedules = _selectedSubjectID == null
        ? widget.availableSchedules
        : widget.availableSchedules
            .where((s) => s.subjectID == _selectedSubjectID)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: const Text(
          'Enroll Student',
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
              const SizedBox(height: 30),
              DropdownButtonFormField<int>(
                value: _selectedStudentID,
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
                items: widget.availableStudents.map((student) {
                  return DropdownMenuItem<int>(
                    value: student.studentID,
                    child: Text(
                      '${student.firstName} ${student.lastName} (${student.studentNumber})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedStudentID = val),
                validator: (val) => val == null ? 'Please select a student.' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                value: _selectedSubjectID,
                dropdownColor: const Color(0xFF5A0000),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Select Subject',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.book, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: widget.availableSubjects.map((subject) {
                  return DropdownMenuItem<int>(
                    value: subject.subjectID,
                    child: Text(
                      '${subject.subjectCode} - ${subject.subjectName}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedSubjectID = val;
                    _selectedScheduleID = null;
                  });
                },
                validator: (val) => val == null ? 'Please select a subject.' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                key: ValueKey('schedule_dropdown_$_selectedSubjectID'),
                value: _selectedScheduleID,
                dropdownColor: const Color(0xFF5A0000),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Select Schedule',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.schedule, color: Color(0xFFFFD700)),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: filteredSchedules.map((schedule) {
                  return DropdownMenuItem<int>(
                    value: schedule.scheduleID,
                    child: Text(
                      '${schedule.dayOfWeek} (${schedule.startTime} - ${schedule.endTime}) - Rm ${schedule.room}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedScheduleID = val),
                validator: (val) => val == null ? 'Please select a schedule.' : null,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: const Text(
                  'Confirm Enrollment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}