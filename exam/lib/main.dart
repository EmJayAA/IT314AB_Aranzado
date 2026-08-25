import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.black),
      ),
      home: const MyHomePage(title: 'Home Page'),
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
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
                'Match Details',
                style: TextStyle(
                  color: Colors.white
                )
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Container(
                color: Color.fromARGB(255, 31, 31, 31),
              child: 
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('My Team',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
                SizedBox(width: 50),
                  Text('12',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
                SizedBox(width: 5),
                  Icon(
                    Icons.gps_fixed_outlined,
                    size: 20.0,
                    color: Colors.white
                  ),
                SizedBox(width: 5),
                  Text('14',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,  
                    color: Colors.white
                  )),
                SizedBox(width: 50),
                  Text('Opponent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
                ]
                )
              )            
            ),
            Card(
              child: Image.asset('assets/Map/ascent.jpg',
              fit:BoxFit.cover)
            ),
            const SizedBox(height: 1),
            Card(
              child: Container(
                color: Color.fromARGB(255, 31, 31, 31),
              child: 
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('My Team',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )),
                SizedBox(width: 100),
                  Icon(
                    Icons.bar_chart,
                    size: 20.0,
                    color: Colors.white70
                  ),
                ]
                )
              )            
            ),
          ],     
        ),
      ),
    );
  }
}
