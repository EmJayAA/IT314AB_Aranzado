import 'package:flutter/material.dart';
import 'PlayerInboxScreen.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key, required this.title});


  final String title;

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}


class _PlayerListScreenState extends State<PlayerListScreen> {


String friends = 'Friends';
String messages = 'Messages';
String requests = 'Requests';
String search = 'Search';
String away = 'Away';
String game = 'VALORANT';
int pcOnlineCount = 3;
int onlineCount = 4;
String user1 = 'MissYouLikeKrazy';
String user2 = 'bread';
String user3 = 'The14th';
String user4 = 'Carlvendish';
String user5 = 'D1yah';
String device = 'Riot Mobile';
bool online = true;
bool playing = true;



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
                  friends,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),  
                SizedBox(width: 20),
                Text(
                  messages,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),
                SizedBox(width: 20),
                Text(
                  requests,
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
                    search,
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
                  game,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                ),  
                SizedBox(width: 10),
                Text(
                  '$pcOnlineCount',
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
          GestureDetector(
             behavior: HitTestBehavior.opaque,    
             onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerInboxScreen()),
                );
             },
          child: Card(
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
                  user1,
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
                      'Online - $game',
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
        ),
        GestureDetector(
            behavior: HitTestBehavior.opaque,     
             onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerInboxScreen()),
                );
             },
        child: Card(
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
                  user2,
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
                      'Playing - $game',
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
        ),
        GestureDetector(
            behavior: HitTestBehavior.opaque,        
             onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerInboxScreen()),
                );
             },
        child: Card(
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
                  user3,
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
                      'Playing - $game',
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
                  '$onlineCount',
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
          GestureDetector(     
            behavior: HitTestBehavior.opaque,   
             onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerInboxScreen()),
                );
             },
          child: Card(
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
                  user4,
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
                      '$away - $device',
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
        ),
        GestureDetector(
                
             onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerInboxScreen()),
                );
             },
        child: Card(
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
                  user5,
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
                      '$away - $device',
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
        ),                          
        ]
      ),
    );
  }
}