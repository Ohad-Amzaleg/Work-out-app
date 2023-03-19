import 'package:flutter/material.dart';
import 'package:my_gym/Util/popup_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/home_page.dart';

class UserValid{

  static void RegValidation(BuildContext context,String email, String password, String username) async {
    dynamic auth = FirebaseAuth.instance;
    try{
      final isValid=await auth.createUserWithEmailAndPassword(email: email, password: password);
      if(isValid!=null){
        Navigator.pushNamed(context, HomePage.id);      }
    }
    on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        PopupMessages.PopUpMsg(context, 'Weak password', 'Please enter a stronger password');
      }
      else if(e.code == 'email-already-in-use'){
        PopupMessages.PopUpMsg(context, 'Email already in use', 'Please enter a different email');
      }
      else{
        PopupMessages.PopUpMsg(context, 'Error', 'An error has occured');
      }
    }
    catch(e){
      print(e);
    }

  }

  static void LoginValidation(BuildContext context,String email, String password) async {
    dynamic auth = FirebaseAuth.instance;

    try{
      final user=await auth.signInWithEmailAndPassword(email: email, password: password);
      if(user!=null){
        Navigator.pushNamed(context, HomePage.id);
      }
    }
    on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        PopupMessages.PopUpMsg(context, 'User not found', 'Please register an account');
      }
      else if(e.code == 'wrong-password'){
        PopupMessages.PopUpMsg(context, 'Wrong password', 'Please enter the correct password');
      }
      else{
        PopupMessages.PopUpMsg(context, 'Error', 'An error has occured');
      }
    }
    catch(e){
      print(e);
    }

  }

}