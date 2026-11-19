import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/grade_model.dart';

class GradeRepository {
  static Future<List<Grade>> getGrades() async {
    try {
      final conn = await DbConnection.getConnection();
      final results = await conn.execute(
        Sql.named(
          '''
          SELECT "GradeID", "EnrollmentID", "GradeValue", "Remarks", "DateRecorded"
          FROM "Grades"
          ORDER BY "GradeID" ASC
          ''',
        ),
      );

      return results.map((row) {
        final map = row.toColumnMap();
        return Grade.fromMap(map);
      }).toList();
    } catch (e) {
      print('=== DATABASE FETCH GRADES ERROR: $e ===');
      return [];
    }
  }

  static Future<void> addGrade(Grade grade) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          '''
          INSERT INTO "Grades" ("EnrollmentID", "GradeValue", "Remarks", "DateRecorded")
          VALUES (@enrollmentId, @gradeValue, @remarks, @dateRecorded)
          ''',
        ),
        parameters: {
          'enrollmentId': grade.enrollmentID,
          'gradeValue': grade.gradeValue,
          'remarks': grade.remarks,
          'dateRecorded': grade.dateRecorded,
        },
      );
    } catch (e) {
      print('=== DATABASE INSERT GRADE ERROR: $e ===');
      rethrow;
    }
  }

  static Future<void> updateGrade(Grade updatedGrade) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          '''
          UPDATE "Grades"
          SET "EnrollmentID" = @enrollmentId,
              "GradeValue" = @gradeValue,
              "Remarks" = @remarks,
              "DateRecorded" = @dateRecorded
          WHERE "GradeID" = @gradeId
          ''',
        ),
        parameters: {
          'gradeId': updatedGrade.gradeID,
          'enrollmentId': updatedGrade.enrollmentID,
          'gradeValue': updatedGrade.gradeValue,
          'remarks': updatedGrade.remarks,
          'dateRecorded': updatedGrade.dateRecorded,
        },
      );
    } catch (e) {
      print('=== DATABASE UPDATE GRADE ERROR: $e ===');
      rethrow;
    }
  }

  static Future<void> deleteGrade(int gradeId) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(
          'DELETE FROM "Grades" WHERE "GradeID" = @gradeId',
        ),
        parameters: {
          'gradeId': gradeId,
        },
      );
    } catch (e) {
      print('=== DATABASE DELETE GRADE ERROR: $e ===');
      rethrow;
    }
  }
}