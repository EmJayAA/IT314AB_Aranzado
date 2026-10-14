import 'package:flutter/material.dart';
import 'screens/StudentListScreen.dart';
import 'screens/StudentDetailsScreen.dart';
import 'screens/AddStudentScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF800000),
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/student-list',
    
      routes: {
        '/student-list': (context) => const StudentListScreen(title: 'Student Directory'),
        '/add-student': (context) => const AddStudentScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/student-details') {
          final profile = settings.arguments as Profile;
          return MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(profile: profile),
          );
        }
        return null;
      },
    );
  }
}