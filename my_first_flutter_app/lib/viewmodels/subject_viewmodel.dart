import 'package:flutter/foundation.dart';
import '../models/subject_model.dart';
import '../repositories/subject_repository.dart';

class SubjectViewModel extends ChangeNotifier {
  List<Subject> _subjects = [];
  bool _isLoading = false;

  List<Subject> get subjects => _subjects;
  bool get isLoading => _isLoading;

  Future<void> fetchSubjects() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _subjects = await SubjectRepository.getSubjects();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNewSubject(Subject subject) async {
    await SubjectRepository.addSubject(subject);
    await fetchSubjects();
  }

  Future<void> editSubject(Subject subject) async {
    await SubjectRepository.updateSubject(subject);
    await fetchSubjects();
  }

  Future<void> removeSubject(int subjectId) async {
    await SubjectRepository.deleteSubject(subjectId);
    await fetchSubjects();
  }
}