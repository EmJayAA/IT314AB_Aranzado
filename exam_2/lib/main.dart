import 'package:flutter/material.dart';
import 'package:exam_2/screens/PlayerListScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam 2',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const PlayerListScreen(title: 'Home Page'),
    );
  }
}
