import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/subject_model.dart';

class SubjectRepository {
  static Future<List<Subject>> getSubjects() async {
    try {
      final conn = await DbConnection.getConnection();
      final results = await conn.execute('SELECT * FROM "Subjects" ORDER BY "SubjectID" ASC;');
      
      return results.map((row) {
        final map = row.toColumnMap();
        return Subject.fromMap(map);
      }).toList();
    } catch (e) {
      print('=== DATABASE FETCH ERROR (Subjects): $e ===');
      return [];
    }
  }

  static Future<void> addSubject(Subject subject) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'''
        INSERT INTO "Subjects" ("SubjectCode", "SubjectName", "Units", "Description") 
        VALUES (@subjectCode, @subjectName, @units, @description)
        '''),
        parameters: {
          'subjectCode': subject.subjectCode,
          'subjectName': subject.subjectName,
          'units': subject.units,
          'description': subject.description,
        },
      );
    } catch (e) {
      print('=== DATABASE INSERT ERROR (Subjects): $e ===');
      rethrow;
    }
  }

  static Future<void> updateSubject(Subject updatedSubject) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'''
        UPDATE "Subjects" 
        SET "SubjectCode" = @subjectCode, "SubjectName" = @subjectName, "Units" = @units, "Description" = @description
        WHERE "SubjectID" = @subjectId
        '''),
        parameters: {
          'subjectId': updatedSubject.subjectID,
          'subjectCode': updatedSubject.subjectCode,
          'subjectName': updatedSubject.subjectName,
          'units': updatedSubject.units,
          'description': updatedSubject.description,
        },
      );
    } catch (e) {
      print('=== DATABASE UPDATE ERROR (Subjects): $e ===');
      rethrow;
    }
  }

  static Future<void> deleteSubject(int subjectId) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'DELETE FROM "Subjects" WHERE "SubjectID" = @subjectId'),
        parameters: {'subjectId': subjectId},
      );
    } catch (e) {
      print('=== DATABASE DELETE ERROR (Subjects): $e ===');
      rethrow;
    }
  }
}