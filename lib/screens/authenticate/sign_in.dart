import 'dart:ui';

import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggelView;
  SignIn({this.toggelView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _auth = AuthServices();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text(" Sign in to Brew crew"),
        elevation: 0.0,
        actions: [
          FlatButton.icon(onPressed: (){
            widget.toggelView();
          }, icon: Icon(Icons.person), label: Text("Register"))
        ],
        
      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
            children: [
              SizedBox(height : 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText : "email"),
                validator: (val)=>(val.isEmpty) ? "Enter valid email" : null,
                onChanged: (val){
                  setState(() {
                     email = val;
                   });
                },
              ),
              SizedBox(height : 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText : "password"),
                validator: (val)=>(val.length<6) ? "Enter a password more than 6 chars" : null,
                obscureText: true,
                 onChanged: (val){
                   setState(() {
                     password = val;
                   });
                 },
              ),
              SizedBox(height : 20.0),
              RaisedButton(
                color: Colors.black,
                onPressed: ()async{
                  
                 if(_formKey.currentState.validate()){
                   setState(() {
                     loading = true;
                   });
                   dynamic result = await _auth.signInWithEmailAndPqssword(email, password);
                   if(result == null){
                     setState(() {
                       error = "couldn't sign in with this email ";
                       loading = false;
                     });

                   }

                 }
                },
              child: Text("Sign-in",style: TextStyle(color: Colors.white),),
              ),
               Text(error, style: TextStyle(color: Colors.red),),
            ],
          ))
        
        ),
        ) ,

    );
  }
}