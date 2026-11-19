import 'package:flutter/foundation.dart';
import '../models/student_model.dart';
import '../repositories/student_repository.dart';

class StudentViewModel extends ChangeNotifier {
  List<Student> _students = [];
  bool _isLoading = false;

  List<Student> get students => _students;
  bool get isLoading => _isLoading;

  Future<void> fetchStudents() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _students = await StudentRepository.getStudents();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNewStudent(Student student) async {
    await StudentRepository.addStudent(student);
    await fetchStudents();
  }

  Future<void> editStudent(Student student) async {
    await StudentRepository.updateStudent(student);
    await fetchStudents();
  }

  Future<void> removeStudent(int studentId) async {
    await StudentRepository.deleteStudent(studentId);
    await fetchStudents();
  }
}