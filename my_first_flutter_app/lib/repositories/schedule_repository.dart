import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  static Future<List<Schedule>> getSchedules() async {
    try {
      final conn = await DbConnection.getConnection();
      final results = await conn.execute('SELECT * FROM "Schedules" ORDER BY "ScheduleID" ASC;');
      
      return results.map((row) {
        final map = row.toColumnMap();
        return Schedule.fromMap(map);
      }).toList();
    } catch (e) {
      print('=== DATABASE FETCH ERROR (Schedules): $e ===');
      return [];
    }
  }

  static Future<void> addSchedule(Schedule schedule) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'''
        INSERT INTO "Schedules" ("SubjectID", "DayOfWeek", "StartTime", "EndTime", "Room", "SlotCapacity") 
        VALUES (@subjectID, @dayOfWeek, @startTime, @endTime, @room, @slotCapacity)
        '''),
        parameters: {
          'subjectID': schedule.subjectID,
          'dayOfWeek': schedule.dayOfWeek,
          'startTime': schedule.startTime,
          'endTime': schedule.endTime,
          'room': schedule.room,
          'slotCapacity': schedule.slotCapacity,
        },
      );
    } catch (e) {
      print('=== DATABASE INSERT ERROR (Schedules): $e ===');
      rethrow;
    }
  }

  static Future<void> updateSchedule(Schedule updatedSchedule) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'''
        UPDATE "Schedules" 
        SET "SubjectID" = @subjectID, "DayOfWeek" = @dayOfWeek, "StartTime" = @startTime, "EndTime" = @endTime, "Room" = @room, "SlotCapacity" = @slotCapacity
        WHERE "ScheduleID" = @scheduleID
        '''),
        parameters: {
          'scheduleID': updatedSchedule.scheduleID,
          'subjectID': updatedSchedule.subjectID,
          'dayOfWeek': updatedSchedule.dayOfWeek,
          'startTime': updatedSchedule.startTime,
          'endTime': updatedSchedule.endTime,
          'room': updatedSchedule.room,
          'slotCapacity': updatedSchedule.slotCapacity,
        },
      );
    } catch (e) {
      print('=== DATABASE UPDATE ERROR (Schedules): $e ===');
      rethrow;
    }
  }

  static Future<void> deleteSchedule(int scheduleId) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'DELETE FROM "Schedules" WHERE "ScheduleID" = @scheduleID'),
        parameters: {'scheduleID': scheduleId},
      );
    } catch (e) {
      print('=== DATABASE DELETE ERROR (Schedules): $e ===');
      rethrow;
    }
  }
}