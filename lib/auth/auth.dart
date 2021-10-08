import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_amplify_todo/auth/accConf.dart';
import 'package:aws_amplify_todo/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {

  Future<void> userSignIn(email, pwd, context) async {
    try{
      SignInResult res = await Amplify.Auth.signIn(username: email, password: pwd);
      Provider.of<UserLoginStatus>(context, listen: false).changeUserStatus(res.isSignedIn); 
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> userSignUp(uname, pwd, phno, email, context) async {
    var attributes = {'phone_number' : '$phno', 'name' : '$uname'};
    try{
      SignUpResult res = await Amplify.Auth.signUp(username: email, password: pwd, options: CognitoSignUpOptions(userAttributes: attributes));
        if (res.isSignUpComplete){
          Navigator.push(context, MaterialPageRoute(builder: (context) => OTPConf(email: email)));
        }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut(context) async {
    try {
        await Amplify.Auth.signOut();
        Provider.of<UserLoginStatus>(context, listen: false).changeUserStatus(false); 
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> confUser(email, confcode, context) async {
    try {
      var res = await Amplify.Auth.confirmSignUp(username: email, confirmationCode: confcode);
      if (res.isSignUpComplete){
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}