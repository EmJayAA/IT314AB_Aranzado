import 'package:flutter/foundation.dart';
import '../models/schedule_model.dart';
import '../repositories/schedule_repository.dart';

class ScheduleViewModel extends ChangeNotifier {
  List<Schedule> _schedules = [];
  bool _isLoading = false;

  List<Schedule> get schedules => _schedules;
  bool get isLoading => _isLoading;

  Future<void> fetchSchedules() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _schedules = await ScheduleRepository.getSchedules();
    
    _isLoading = false;
    notifyListeners();
  }

  bool hasConflict(Schedule newSchedule) {
    final newStart = _tryTimeToMinutes(newSchedule.startTime);
    final newEnd = _tryTimeToMinutes(newSchedule.endTime);
    if (newStart == null || newEnd == null) return false;

    for (var existing in _schedules) {
      if (existing.scheduleID == newSchedule.scheduleID) continue;

      final sameDay = existing.dayOfWeek.trim().toLowerCase() ==
          newSchedule.dayOfWeek.trim().toLowerCase();
      final sameRoom = existing.room.trim().toLowerCase() ==
          newSchedule.room.trim().toLowerCase();

      if (!sameDay || !sameRoom) continue;

      final existingStart = _tryTimeToMinutes(existing.startTime);
      final existingEnd = _tryTimeToMinutes(existing.endTime);
      if (existingStart == null || existingEnd == null) continue;

      if (newStart < existingEnd && newEnd > existingStart) {
        return true;
      }
    }
    return false;
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

  Future<void> addNewSchedule(Schedule schedule) async {
    if (hasConflict(schedule)) {
      throw Exception('Schedule Conflict: Room "${schedule.room}" is already booked on ${schedule.dayOfWeek} during this time slot!');
    }
    await ScheduleRepository.addSchedule(schedule);
    await fetchSchedules();
  }

  Future<void> editSchedule(Schedule schedule) async {
    if (hasConflict(schedule)) {
      throw Exception('Schedule Conflict: Room "${schedule.room}" is already booked on ${schedule.dayOfWeek} during this time slot!');
    }
    await ScheduleRepository.updateSchedule(schedule);
    await fetchSchedules();
  }

  Future<void> removeSchedule(int scheduleId) async {
    await ScheduleRepository.deleteSchedule(scheduleId);
    await fetchSchedules();
  }
}