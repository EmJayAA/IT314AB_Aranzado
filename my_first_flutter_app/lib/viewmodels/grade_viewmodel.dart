import 'package:flutter/foundation.dart';
import '../models/grade_model.dart';
import '../repositories/grade_repository.dart';

class GradeViewModel extends ChangeNotifier {
  List<Grade> _grades = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Grade> get grades => _grades;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchGrades() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _grades = await GradeRepository.getGrades();
    } catch (e) {
      _errorMessage = 'Failed to load grades: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Grade? findGradeByEnrollmentId(int enrollmentId) {
    for (final grade in _grades) {
      if (grade.enrollmentID == enrollmentId) {
        return grade;
      }
    }
    return null;
  }

  Future<void> addNewGrade(Grade grade) async {
    _errorMessage = null;
    try {
      await GradeRepository.addGrade(grade);
      await fetchGrades();
    } catch (e) {
      _errorMessage = 'Failed to add grade: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> editGrade(Grade grade) async {
    _errorMessage = null;
    try {
      await GradeRepository.updateGrade(grade);
      await fetchGrades();
    } catch (e) {
      _errorMessage = 'Failed to update grade: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeGrade(int gradeId) async {
    _errorMessage = null;
    try {
      await GradeRepository.deleteGrade(gradeId);
      await fetchGrades();
    } catch (e) {
      _errorMessage = 'Failed to delete grade: $e';
      notifyListeners();
      rethrow;
    }
  }
}