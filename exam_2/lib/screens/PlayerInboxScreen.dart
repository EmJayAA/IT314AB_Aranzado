import 'package:flutter/material.dart';

class PlayerInboxScreen extends StatelessWidget   {
  const PlayerInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Player Inbox',
            style: const TextStyle(
            color: Colors. white,
            fontWeight: FontWeight.bold,
              ), // TextStyle
            ), // Text
          centerTitle: true,
          ), // AppBar
        body: Center(
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
                      'Online - Game',
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
          ),) 
    );
  }
}