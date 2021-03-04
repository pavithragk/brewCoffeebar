import 'package:brew_crew/models/UserModel.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStregth;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(children: [
                Text(
                  "Update your brew settings",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      (val.isEmpty) ? "Please enter  a name" : null,
                  onChanged: (val) =>
                      setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration,
                    onChanged: (val) {
                      _currentSugars = val;
                    },
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars'));
                    }).toList()),
                Slider(
                    value: (_currentStregth ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStregth ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStregth ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStregth = val.round())),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseServices(uid: userData.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStregth ?? userData.strength);
                    }
                    Navigator.pop(context);
                  },
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]));
        } else {
          return Loading();
        }
      },
    );
  }
}
