import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firstprojectiwm/view/Mydrawer.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  String? mail;
  String? password;
  dashboard(String? this.mail, String? this.password);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardState();
  }

}

class dashboardState extends State<dashboard> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Ici on met ce qu'on veut, on recommance une nouvelle page en faite
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        title: Text('Nouvelle Page'),
      ),
      body: bodyPage(currentIndex),
      bottomNavigationBar: DotNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
        onTap: (int newValue) {
          setState(() {
            currentIndex = newValue;
          });
        },
        currentIndex: currentIndex,
        items: [
          DotNavigationBarItem(
              icon: Icon(Icons.music_note_sharp),
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.person),
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.map_sharp),
          ),
        ],
      ),
    );
  }

  Widget bodyPage(int value) {
    switch (value) {
      case 0 : return Text('un');
      case 1 : return Text('deux');
      case 2 : return Text('trois');
      default : return Text('Rien');
    }
  }

}