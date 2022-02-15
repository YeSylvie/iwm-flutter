import 'package:firebase_core/firebase_core.dart';
import 'package:firstprojectiwm/view/dashboard.dart';
import 'package:firstprojectiwm/view/inscription.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'functions/firestoreHelper.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String? mail; // Avec le ? ça veut dire que c'est une variable optionnel sinon faut mettre une valeur par défaut
  String? password;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text("Bienvenue"),

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: bodyPage()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("pandaiwm.png"),
                    fit: BoxFit.fill
                )
            )
        ),
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
            FirestoreHelper().ConnectUser(mail: mail!, password: password!).then((value) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return dashboard(mail, password);
                  }
              ));
            }).catchError((error) {
              print('error');
            });
          },
          child: Text('Connexion')
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return inscription();
              }
            ));
          },
          child: Text('Inscription', style: TextStyle(color: Colors.blue),),
        ),
      ],
    );

  }
}

