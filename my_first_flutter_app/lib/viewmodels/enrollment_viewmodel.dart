import 'package:flutter/foundation.dart';
import '../models/enrollment_model.dart';
import '../models/schedule_model.dart';
import '../repositories/enrollment_repository.dart';

class EnrollmentViewModel extends ChangeNotifier {
  List<Enrollment> _enrollments = [];
  bool _isLoading = false;

  List<Enrollment> get enrollments => _enrollments;
  bool get isLoading => _isLoading;

  Future<void> fetchEnrollments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _enrollments = await EnrollmentRepository.getEnrollments();

    _isLoading = false;
    notifyListeners();
  }

  bool hasStudentScheduleConflict(
    Enrollment candidateEnrollment,
    List<Schedule> allSchedules,
  ) {
    final candidateSchedule = _findScheduleById(allSchedules, candidateEnrollment.scheduleID);
    if (candidateSchedule == null) return false;

    final candidateStart = _tryTimeToMinutes(candidateSchedule.startTime);
    final candidateEnd = _tryTimeToMinutes(candidateSchedule.endTime);
    if (candidateStart == null || candidateEnd == null) return false;

    for (final existing in _enrollments) {
      if (existing.enrollmentID == candidateEnrollment.enrollmentID) continue;
      if (existing.studentID != candidateEnrollment.studentID) continue;
      if (existing.status.trim().toLowerCase() == 'dropped' ||
          existing.status.trim().toLowerCase() == 'cancelled') {
        continue;
      }

      final existingSchedule = _findScheduleById(allSchedules, existing.scheduleID);
      if (existingSchedule == null) continue;

      final sameDay = existingSchedule.dayOfWeek.trim().toLowerCase() ==
          candidateSchedule.dayOfWeek.trim().toLowerCase();
      if (!sameDay) continue;

      final existingStart = _tryTimeToMinutes(existingSchedule.startTime);
      final existingEnd = _tryTimeToMinutes(existingSchedule.endTime);
      if (existingStart == null || existingEnd == null) continue;

      if (candidateStart < existingEnd && candidateEnd > existingStart) {
        return true;
      }
    }

    return false;
  }

  Schedule? _findScheduleById(List<Schedule> schedules, int scheduleId) {
    for (final schedule in schedules) {
      if (schedule.scheduleID == scheduleId) {
        return schedule;
      }
    }
    return null;
  }

  int? _tryTimeToMinutes(String timeStr) {
    try {
      String cleaned = timeStr.replaceAll(RegExp(r'Time\(|\)'), '').trim();
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

  Future<void> addNewEnrollment(
    Enrollment enrollment, {
    List<Schedule>? availableSchedules,
  }) async {
    if (availableSchedules != null &&
        hasStudentScheduleConflict(enrollment, availableSchedules)) {
      throw Exception(
        'Schedule Conflict: This student already has an overlapping class on this day and time!',
      );
    }

    await EnrollmentRepository.addEnrollment(enrollment);
    await fetchEnrollments();
  }

  Future<void> editEnrollment(
    Enrollment enrollment, {
    List<Schedule>? availableSchedules,
  }) async {
    if (availableSchedules != null &&
        hasStudentScheduleConflict(enrollment, availableSchedules)) {
      throw Exception(
        'Schedule Conflict: This student already has an overlapping class on this day and time!',
      );
    }

    await EnrollmentRepository.updateEnrollment(enrollment);
    await fetchEnrollments();
  }

  Future<void> removeEnrollment(int enrollmentId) async {
    await EnrollmentRepository.deleteEnrollment(enrollmentId);
    await fetchEnrollments();
  }
}