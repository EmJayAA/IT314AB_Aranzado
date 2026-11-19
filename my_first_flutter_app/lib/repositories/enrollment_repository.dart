import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/enrollment_model.dart';

class EnrollmentRepository {
  static Future<List<Enrollment>> getEnrollments() async {
    try {
      final conn = await DbConnection.getConnection();
      final result = await conn.execute(
        Sql.named(
          '''
          SELECT "EnrollmentID", "StudentID", "SubjectID", "ScheduleID", "EnrolledAt", "Status"
          FROM "Enrollments"
          ORDER BY "EnrollmentID" ASC
          ''',
        ),
      );

      return result.map((row) {
        final map = row.toColumnMap();
        return Enrollment.fromMap(map);
      }).toList();
    } catch (e) {
      print('=== DATABASE FETCH ENROLLMENTS ERROR: $e ===');
      return [];
    }
  }

  static Future<void> addEnrollment(Enrollment enrollment) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          '''
          INSERT INTO "Enrollments" ("StudentID", "SubjectID", "ScheduleID", "EnrolledAt", "Status")
          VALUES (@studentId, @subjectId, @scheduleId, @enrolledAt, @status)
          ''',
        ),
        parameters: {
          'studentId': enrollment.studentID,
          'subjectId': enrollment.subjectID,
          'scheduleId': enrollment.scheduleID,
          'enrolledAt': enrollment.enrolledAt,
          'status': enrollment.status,
        },
      );
    } catch (e) {
      print('=== DATABASE INSERT ENROLLMENT ERROR: $e ===');
      rethrow;
    }
  }

  static Future<void> updateEnrollment(Enrollment updatedEnrollment) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          '''
          UPDATE "Enrollments"
          SET "StudentID" = @studentId,
              "SubjectID" = @subjectId,
              "ScheduleID" = @scheduleId,
              "EnrolledAt" = @enrolledAt,
              "Status" = @status
          WHERE "EnrollmentID" = @enrollmentId
          ''',
        ),
        parameters: {
          'enrollmentId': updatedEnrollment.enrollmentID,
          'studentId': updatedEnrollment.studentID,
          'subjectId': updatedEnrollment.subjectID,
          'scheduleId': updatedEnrollment.scheduleID,
          'enrolledAt': updatedEnrollment.enrolledAt,
          'status': updatedEnrollment.status,
        },
      );
    } catch (e) {
      print('=== DATABASE UPDATE ENROLLMENT ERROR: $e ===');
      rethrow;
    }
  }

  static Future<void> deleteEnrollment(int enrollmentId) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          'DELETE FROM "Enrollments" WHERE "EnrollmentID" = @enrollmentId',
        ),
        parameters: {
          'enrollmentId': enrollmentId,
        },
      );
    } catch (e) {
      print('=== DATABASE DELETE ENROLLMENT ERROR: $e ===');
      rethrow;
    }
  }
}