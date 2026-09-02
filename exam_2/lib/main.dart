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
      debugShowCheckedModeBanner: false,
      title: 'Exam 2',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;
  final String friends = 'Friends';
  final String messages = 'Messages';
  final String requests = 'Requests';


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Social',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
                Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),  
                SizedBox(width: 20),
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(width: 20),
                Text(
                  'Requests',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(width: 20),
              ]
              )
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: 
              Card(
                color: const Color.fromARGB(255, 32, 32, 32), 
                child:
            Row(
              children: [
                  SizedBox(width: 20),
                  Icon(
                    Icons.search,  
                    color: Colors.white54
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Search',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                  )
                  )
                ]
              )
              )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'V',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  )
                ),
                SizedBox(width: 10),
                Text(
                  'VALORANT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),  
                SizedBox(width: 10),
                Text(
                  '3',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                  )
                ),
                SizedBox(width: 20),
              ]
              )
            )
          ),      
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
              Column(
                children:[
                  CircleAvatar( 
                    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                    child:
                    Icon(Icons.person,
                    size: 30.0,
                    color: Colors.red)
                  ),
                  Icon(Icons.circle,
                  color: Colors.green,
                  size: 15)
                ]
              ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  'MissYouLikeKrazy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.monitor,
                    size: 20,
                    color: Colors.white54),
                    SizedBox(width: 5),
                    Text(
                      'Online - VALORANT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54
                      )
                    ),
                  ],
                )
              ]
            )       
              ]
            ),
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
              Column(
                children:[
                  CircleAvatar( 
                    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                    child:
                    Icon(Icons.person,
                    size: 30.0,
                    color: Colors.red)
                  ),
                  Icon(Icons.play_circle,
                  color: Colors.blue,
                  size: 15)
                ]
              ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  'bread',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.monitor,
                    size: 20,
                    color: Colors.white54),
                    SizedBox(width: 5),
                    Text(
                      'Playing - VALORANT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54
                      )
                    ),
                  ],
                )
              ]
            )       
              ]
            ),
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
              Column(
                children:[
                  CircleAvatar( 
                    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                    child:
                    Icon(Icons.person,
                    size: 30.0,
                    color: Colors.red)
                  ),
                  Icon(Icons.play_circle,
                  color: Colors.blue,
                  size: 15)
                ]
              ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  'The14th',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.monitor,
                    size: 20,
                    color: Colors.white54),
                    SizedBox(width: 5),
                    Text(
                      'Playing - VALORANT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54
                      )
                    ),
                  ],
                )
              ]
            )       
            ]
            ),
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),  
                SizedBox(width: 10),
                Text(
                  '4',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                  )
                ),
                SizedBox(width: 20),
              ]
              )
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
              Column(
                children:[
                  CircleAvatar( 
                    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                    child:
                    Icon(Icons.person,
                    size: 30.0,
                    color: Colors.white)
                  ),
                  Icon(Icons.dark_mode,
                  color: Colors.yellow,
                  size: 15)
                ]
              ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  'Carlvendish',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.mobile_friendly,
                    size: 20,
                    color: Colors.white54),
                    SizedBox(width: 5),
                    Text(
                      'Away - Riot Mobile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54
                      )
                    ),
                  ],
                )
              ]
            )       
            ]
            ),
            )
          ),
          Card(
            margin: EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 0,
            ),
            child: Container(
              color: Colors.black,
            child:
            Row(
              children: [
              Column(
                children:[
                  CircleAvatar( 
                    backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                    child:
                    Icon(Icons.person,
                    size: 30.0,
                    color: Colors.white)
                  ),
                  Icon(Icons.dark_mode,
                  color: Colors.yellow,
                  size: 15)
                ]
              ),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  'D1yah',
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.mobile_friendly,
                    size: 20,
                    color: Colors.white54),
                    SizedBox(width: 5),
                    Text(
                      'Away - Riot Mobile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54
                      )
                    ),
                  ],
                )
              ]
            )       
            ]
            ),
            )
          ),                          
        ]
      ),
    );
  }
}
