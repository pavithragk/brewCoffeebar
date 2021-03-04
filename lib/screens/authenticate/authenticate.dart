import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isSignIn = true;

  void toggelView(){
    setState(() {
      isSignIn =!isSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    
       if(isSignIn){
        return SignIn(toggelView : toggelView);
        
      }else{
        return Register(toggelView : toggelView);
      }
      
    
  }
}