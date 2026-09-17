import 'package:flutter/material.dart';
import 'screens/StudentListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF800000),
          brightness: Brightness.dark,
        ),
      ),
      home: const StudentListScreen(title: 'Student Directory'),
    );
  }
}
