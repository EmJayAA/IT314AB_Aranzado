import 'package:postgres/postgres.dart';
import '../core/db_connection.dart';
import '../models/student_model.dart';

class StudentRepository {
  static Future<List<Student>> getStudents() async {
    try {
      final conn = await DbConnection.getConnection();
      final results = await conn.execute('SELECT * FROM "Students" ORDER BY "StudentID" ASC;');
      
      return results.map((row) {
        final map = row.toColumnMap();
        return Student.fromMap(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> addStudent(Student student) async {
    try {
      final conn = await DbConnection.getConnection();
      // Sql.named wraps the SQL query string
      await conn.execute(
        Sql.named(r'''
        INSERT INTO "Students" ("StudentNumber", "FirstName", "LastName", "Email", "Course", "YearLevel", "ContactNumber", "CreatedAt") 
        VALUES (@studentNumber, @firstName, @lastName, @email, @course, @yearLevel, @contactNumber, @createdAt)
        '''),
        parameters: {
          'studentNumber': student.studentNumber,
          'firstName': student.firstName,
          'lastName': student.lastName,
          'email': student.email,
          'course': student.course,
          'yearLevel': student.yearLevel,
          'contactNumber': student.contactNumber,
          'createdAt': student.createdAt,
        },
      );
    } catch (e) {
      print('=== DATABASE INSERT ERROR: $e ===');
      rethrow;
    }
  }

  static Future<void> updateStudent(Student student) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'''
        UPDATE "Students" 
        SET "StudentNumber" = @studentNumber, "FirstName" = @firstName, "LastName" = @lastName, "Email" = @email, "Course" = @course, "YearLevel" = @yearLevel, "ContactNumber" = @contactNumber
        WHERE "StudentID" = @studentId
        '''),
        parameters: {
          'studentId': student.studentID,
          'studentNumber': student.studentNumber,
          'firstName': student.firstName,
          'lastName': student.lastName,
          'email': student.email,
          'course': student.course,
          'yearLevel': student.yearLevel,
          'contactNumber': student.contactNumber,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteStudent(int studentId) async {
    try {
      final conn = await DbConnection.getConnection();
      await conn.execute(
        Sql.named(r'DELETE FROM "Students" WHERE "StudentID" = @studentId'),
        parameters: {'studentId': studentId},
      );
    } catch (e) {
      rethrow;
    }
  }
}