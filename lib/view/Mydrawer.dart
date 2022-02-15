import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firstprojectiwm/functions/firestoreHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';

class myDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }

}

class myDrawerState extends State<myDrawer> {
  String? identifiant;
  Users? utilistateur;
  DateTime time = DateTime.now();
  String imageFilePath = "";
  Uint8List? bytesImage;
  String imageFileName = "";

  @override
  Widget build(BuildContext context) {
    FirestoreHelper().getIdentifiant().then((value) {
      setState(() {
        identifiant = value;
      });
    });
    FirestoreHelper().getUser(identifiant!).then((value) {
      setState(() {
        utilistateur = value;
      });
    });
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width/2,
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: (utilistateur!.image == null)? NetworkImage("https://firebasestorage.googleapis.com/v0/b/iconic-glider-333009.appspot.com/o/pas_image.png?alt=media&token=1e46f383-2077-4900-8cb2-0ef879824d73") : NetworkImage(utilistateur!.image!),
                        fit: BoxFit.fill
                    )
                )
            ),
            onTap: () {
              (utilistateur!.image == null)  ? Container() : afficherImage();
            },
            onLongPress: () async {
              FilePickerResult? resultat = await FilePicker.platform.pickFiles(
                withData: true,
                type: FileType.image,
              );
              if (resultat!=null) {
                setState(() {
                  imageFileName = resultat.files.first.name;
                  bytesImage = resultat.files.first.bytes;
                  print(imageFileName);
                });
              }
            },
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              (utilistateur!.pseudo == null) ? Text("") : Text("${utilistateur!.pseudo}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              IconButton(
                onPressed: () {
                  BoxEdit();
                },
                icon: Icon(Icons.edit),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.mail),
              Text("${utilistateur?.mail}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 10,),
          Text("${utilistateur?.nom} ${utilistateur!.prenom}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),
          (utilistateur!.dateNaissance == null) ? Text(time.toString()) : Text(utilistateur!.dateNaissance!.toString()),
          IconButton(
              onPressed: () {
                FirestoreHelper().logUser();
                //Chemin vers la page principal
              },
              icon: Icon(Icons.exit_to_app_rounded)
          ),
          IconButton(
              onPressed: () {
                //Création d'une boite de dialogue
                BoxDelete();
              },
              icon: Icon(Icons.logout, color: Colors.red,)
          ),
        ],
      )
    );
  }

  BoxDelete() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if(Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text('Suppression du compte définitivement'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Non')
                ),
                ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Oui')
                ),
              ],
            );
          }
          return AlertDialog(
            title: Text('Suppression du compte définitivement'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Non')
              ),
              ElevatedButton(
                  onPressed: () {

                  },
                  child: Text('Oui')
              ),
            ],
          );
        }
    );
  }

  afficherImage() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('us enregistrer cette image ?'),
            content: Image.network(utilistateur!.image!, width: 400, height: 400,),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler')
              ),
              ElevatedButton(
                  onPressed: () {
                    FirestoreHelper().stockageImage(imageFileName, bytesImage!).then((value) {
                      setState(() {
                        imageFilePath = value;
                      });
                      Map<String,dynamic> map = {
                        "IMAGE": imageFilePath,
                      };
                      FirestoreHelper().updateUser(utilistateur!.id, map);
                    });
                  },
                  child: Text('Enregistrer')
              ),
            ],
          );
        }
    );
  }

  BoxEdit() {
    String update = "";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Modification du psuedo'),
            content: TextField(
              onChanged: (newValue) {
                setState(() {
                  update = newValue;
                });
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler')
              ),
              ElevatedButton(
                  onPressed: () {
                    Map<String,dynamic> map = {
                      "PSEUDO": update
                    };
                    FirestoreHelper().updateUser(utilistateur!.id, map);
                  },
                  child: Text('Enregistrer')
              ),
            ],
          );
        }
    );
  }

}