import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    void _openBottomSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          ),
        );

      });
    }

    AuthServices _auth = AuthServices();
    return StreamProvider<List<Brew>>.value(value: DatabaseServices().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Brew Crew"),
          elevation: 0.0,
          actions: [
            FlatButton.icon(onPressed: ()async{
              await _auth.signOut();
            }, icon: Icon(Icons.person), label: Text("logout")),
            FlatButton.icon(onPressed: (){
              _openBottomSheet();
            }, icon: Icon(Icons.settings), label: Text("settings")),
          ],),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/coffee1.png",
              ),
              fit: BoxFit.cover)
            ),
            child: BrewList()),

      ),
    );
  }
}