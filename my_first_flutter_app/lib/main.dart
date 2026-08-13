import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'My First Flutter Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Profile{
  String? name;
  String? courseAndsection;
  int? age;
  Set<String>? hobbies;
  double? height;
  bool? studentStatus;
  String? imagePath;

  Profile({
    this.name,
    this.courseAndsection,
    this.age,
    this.hobbies,
    this.height,
    this.studentStatus,
    this.imagePath
  }
  );
}

class _MyHomePageState extends State<MyHomePage> {

  List<Profile> profiles = [
    Profile(
      imagePath: 'assets/IronMan Logo.png',
      name: 'Iron Man',
      courseAndsection: 'BS Engineering - 4',
      age: 23,
      hobbies: {'Building Suits','AI management'},
      height: 185.2,
      studentStatus: true,
    ),
    Profile(
      imagePath: 'assets/Spiderman Logo.png',
      courseAndsection: 'BSIT - 2',
      age: 19,
      hobbies: {'Photography','Web Slinging'},
      height: 175.2,
      studentStatus: true,
    ),
    Profile(
      name: 'Batman',
      courseAndsection: 'BS Criminology - 4',
      age: 24,
      hobbies: {'Martial Arts','Learning new languages'},
      height: 186.5,
      studentStatus: false,
    ),
    Profile(
      imagePath: 'assets/Superman Logo.png',
      name: 'Superman',
      courseAndsection: 'BA Journalism- 3',
      hobbies: {'Reporting','Farming'},
      height: 187.0,
      studentStatus: true,
    ),
    Profile(
      imagePath: 'assets/Captain America Logo.png',
      name: 'Captain America',
      age: 30,
      hobbies: {'Boxing','Drawing'},
      height: 189.0,
      studentStatus: false,
    ),
  ];

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: profiles.map((profile) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child:Card(
            elevation: 8,
            color: const Color(0xFF2A0808),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Color(0xFFFFD700),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: (profile.imagePath?.isNotEmpty == true)
                        ? Image.asset(
                            profile.imagePath!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white54,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    profile.name ?? 'Name Unknown',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.courseAndsection ?? 'Course: Unknown',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Age: ${profile.age?.toString() ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hobbies: ${(profile.hobbies != null && profile.hobbies!.isNotEmpty) ? profile.hobbies!.join(", ") : "Not provided"}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Height: ${profile.height!= null ? "${profile.height} cm" : "Unknown"}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enrolled: ${profile.studentStatus != null ? (profile.studentStatus! ? "Yes" : "No") : "Not provided"}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
     }).toList(),
    ),
        ),
      ),  
    );
  }
}