import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/student/StudentListScreen.dart';
import 'screens/student/StudentDetailsScreen.dart';
import 'screens/student/AddStudentScreen.dart';
import 'screens/subject/SubjectListScreen.dart';
import 'screens/schedule/ScheduleListScreen.dart';
import 'screens/enrollment/EnrollmentListScreen.dart';
import 'screens/grade/GradeListScreen.dart';
import 'models/student_model.dart';
import 'viewmodels/student_viewmodel.dart';
import 'viewmodels/subject_viewmodel.dart';
import 'viewmodels/schedule_viewmodel.dart';
import 'viewmodels/enrollment_viewmodel.dart';
import 'viewmodels/grade_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const maroonColor = Color(0xFF800000);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentViewModel()),
        ChangeNotifierProvider(create: (_) => SubjectViewModel()),
        ChangeNotifierProvider(create: (_) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => EnrollmentViewModel()),
        ChangeNotifierProvider(create: (_) => GradeViewModel()),
      ],
      child: MaterialApp(
        title: 'Student Directory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: maroonColor,
            brightness: Brightness.dark,
          ),
        ),
        initialRoute: '/student-list',
        routes: {
          '/student-list': (context) => const StudentListScreen(title: 'Student Directory'),
          '/add-student': (context) => const AddStudentScreen(),
          '/subject-list': (context) => const SubjectListScreen(title: 'Subject Catalog'),
          '/schedule-list': (context) => const ScheduleListScreen(title: 'Class Schedules'),
          '/enrollment-list': (context) => const EnrollmentListScreen(title: 'Student Enrollments'),
          '/grade-list': (context) => const GradeListScreen(title: 'Grade Records'),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/student-details') {
            final student = settings.arguments as Student;
            return MaterialPageRoute(
              builder: (context) => StudentDetailsScreen(student: student),
            );
          }
          return null;
        },
      ),
    );
  }
}