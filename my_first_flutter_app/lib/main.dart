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

class _MyHomePageState extends State<MyHomePage> {
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
            children: [
            Card(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular ID Profile Picture
                  ClipOval(
                    child: Image.asset(
                      'assets/MJ ID PIC.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Martin Jonas A. Aranzado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'BSIT - 3',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'My First Flutter Application',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'August 1, 2026',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Helvetica',
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Nicknames: MJ or Emjay',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    )
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Birthdate: March 29, 2005',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Helvetica',
                          color: Colors.white60,)
                          ),
                      SizedBox (width: 10),
                       Text('Age: 21',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Helvetica',
                          color: Colors.white60,)
                          ),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ABOUT ME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Color(0xFFFFD700), 
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 12),
                  const Text(
                    'Educational Background:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                      'assets/SRCDC Logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                      SizedBox (width: 20),
                      Image.asset(
                      'assets/DBTC Logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Future Ambition:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Helvetica',
                          color: Colors.white,)
                          ),
                      SizedBox (width: 10),
                      Expanded(
                       child: Text('Future Salesian with useful IT Skills and Knowledge.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          color: Colors.white60,)
                          ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Favorite Quote:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Helvetica',
                          color: Colors.white,)
                          ),
                      SizedBox (width: 10),
                      Expanded(
                       child: Text("\"If it is not God\'s will, we cannot force it, but if it is God\'s will, we cannot stop it.\"",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontStyle: FontStyle.italic,
                          color: Colors.white60,)
                          ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
            ]
        ),
      ),
    ),
    );
  }
}