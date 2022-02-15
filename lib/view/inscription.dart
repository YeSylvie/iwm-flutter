import 'package:firstprojectiwm/view/dashboard.dart';
import 'package:flutter/material.dart';

import '../functions/firestoreHelper.dart';

class inscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return inscriptionState();
  }

}

class inscriptionState extends State<inscription> {

  String? nom;
  String? prenom;
  String? mail;
  String? password;

  @override
  Widget build(BuildContext context) {
    // Ici on met ce qu'on veut, on recommance une nouvelle page en faite
    return Scaffold(
      appBar: AppBar(
        title: Text("Page d'inscription"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage() {
    return Column(
      children: [
        TextField(
          onChanged: (String text) {
            setState(() {
              nom = text;
            });
          },
          decoration: InputDecoration(
              icon: Icon(Icons.account_circle, color: Colors.pink),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),

        ),
        SizedBox(height: 15,),
        TextField(
          onChanged: (String text) {
            setState(() {
              prenom = text;
            });
          },
          decoration: InputDecoration(
              icon: Icon(Icons.account_circle, color: Colors.pink),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),

        ),
        SizedBox(height: 15,),
        TextField(
          onChanged: (String text) {
            setState(() {
              mail = text;
            });
          },
          decoration: InputDecoration(
              icon: Icon(Icons.mail, color: Colors.pink),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),

        ),
        SizedBox(height: 15,),
        TextField(
          obscureText: true,
          onChanged: (String text) {
            setState(() {
              password = text;
            });
          },
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.pink),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
        ),
        ElevatedButton(
            onPressed: () {
              FirestoreHelper().CreationUser(mail: mail, password: password, nom: nom, prenom: prenom);
            },
            child: Text("s'inscrire"),
        ),

      ],
    );
  }

}