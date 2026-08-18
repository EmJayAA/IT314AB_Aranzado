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
  String? studentId;
  String? email;
  String? phoneNumber;

  Profile({
    this.name,
    this.courseAndsection,
    this.age,
    this.hobbies,
    this.height,
    this.studentStatus,
    this.imagePath,
    this.studentId,
    this.email,
    this.phoneNumber
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
      studentId: '2020-0001',
      email: 'ironman@dbtc.edu.ph',
      phoneNumber: '09171234567',
      studentStatus: true,
    ),
    Profile(
      imagePath: 'assets/Spiderman Logo.png',
      name: 'Spiderman',
      courseAndsection: 'BSIT - 2',
      age: 19,
      hobbies: {'Photography','Web Slinging'},
      height: 175.2,
      studentId: '2020-0002',
      email: 'spiderman@dbtc.edu.ph',
      phoneNumber: '09182345678',
      studentStatus: true,
    ),
    Profile(
      imagePath: 'assets/Batman Logo.png',
      name: 'Batman',
      courseAndsection: 'BS Criminology - 4',
      age: 24,
      hobbies: {'Martial Arts','Learning new languages'},
      height: 186.5,
      studentId: '2020-0003',
      email: 'batman@dbtc.edu.ph',
      phoneNumber: '09193456789',
      studentStatus: false,
    ),
    Profile(
      imagePath: 'assets/Superman Logo.png',
      name: 'Superman',
      courseAndsection: 'BA Journalism- 3',
      age: 22,
      hobbies: {'Reporting','Farming'},
      height: 187.0,
      studentId: '2020-0004',
      email: 'superman@dbtc.edu.ph',
      phoneNumber: '09204567890',
      studentStatus: true,
    ),
    Profile(
      imagePath: 'assets/Captain America Logo.png',
      name: 'Captain America',
      courseAndsection: 'BS Military Science - 4',
      age: 30,
      hobbies: {'Boxing','Drawing'},
      height: 189.0,
      studentId: '2020-0005',
      email: 'captainamerica@dbtc.edu.ph',
      phoneNumber: '09215678901',
      studentStatus: false,
    ),
    Profile(
      imagePath: 'assets/Flash Logo.png',
      name: 'Flash',
      courseAndsection: 'BS Physics - 2',
      age: 21,
      hobbies: {'Sprinting','Forensics'},
      height: 180.0,
      studentId: '2020-0006',
      email: 'ironman@dbtc.edu.ph',
      phoneNumber: '09226789012',
      studentStatus: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    profiles.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
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
      body: profiles.isEmpty ?
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No Student Found.',
            style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white,)),
            SizedBox(height: 5),
            Text('Your student profile is currently empty.',
            style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                      color: Colors.white70,)),
            SizedBox(height: 20)
          ]
          )
        )
      : ListView.builder(
          padding: const EdgeInsets.all(20.0),
            itemCount: profiles.length,
            itemBuilder: (context, index){
            final profile = profiles[index];  
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
                    'Student ID: ${profile.studentId ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Email: ${profile.email ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Contact No.: ${profile.phoneNumber ?? 'N/A'}',
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
        }
      ),  
    );
  }
}