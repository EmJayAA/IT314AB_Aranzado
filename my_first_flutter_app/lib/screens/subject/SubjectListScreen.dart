import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/subject_model.dart';
import '../../viewmodels/subject_viewmodel.dart';
import 'AddSubjectScreen.dart';
import 'SubjectDetailsScreen.dart';
import '../app_drawer.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({super.key, required this.title});

  final String title;

  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  late final SubjectViewModel _subjectViewModel;

  @override
  void initState() {
    super.initState();
    _subjectViewModel = Provider.of<SubjectViewModel>(context, listen: false);
    _subjectViewModel.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0000),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final existingCodes = _subjectViewModel.subjects
                  .map((s) => s.subjectCode)
                  .where((code) => code.isNotEmpty)
                  .toList();

              final newSubjectData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSubjectScreen(
                    existingSubjectCodes: existingCodes,
                  ),
                ),
              );

              if (newSubjectData != null && newSubjectData is Subject) {
                await _subjectViewModel.addNewSubject(newSubjectData);
              }
            },
          ),
        ],
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListenableBuilder(
        listenable: _subjectViewModel,
        builder: (context, child) {
          if (_subjectViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (_subjectViewModel.subjects.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Subject Found.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your subject catalog is currently empty.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: _subjectViewModel.subjects.length,
            itemBuilder: (context, index) {
              final subject = _subjectViewModel.subjects[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectDetailsScreen(subject: subject),
                      ),
                    );
                    _subjectViewModel.fetchSubjects();
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Color(0xFFFFD700),
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.book, size: 40, color: Colors.white54),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                subject.subjectName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Colors.yellow,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Code: ${subject.subjectCode}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Helvetica',
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Units: ${subject.units}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () async {
                              await _subjectViewModel.removeSubject(subject.subjectID);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}