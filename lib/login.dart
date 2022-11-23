import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ws_firebase_dinesh/HomeScreen.dart';

import 'package:ws_firebase_dinesh/main.dart';
import 'package:ws_firebase_dinesh/singup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var controllerPassword = TextEditingController();
  var controllerEmail = TextEditingController();

  void Login ()async{

    String Password = controllerPassword.text.trim();
    String Email = controllerEmail.text.trim();

    if(  Password == ""  || Email == "") {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('fill all the credentials !'),
        );
      }
      );
    }
    else {
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: Email, password: Password);
        if (userCredential.user!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }
      } on FirebaseAuthException catch(ex){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(ex.code.toString()),
          );
        }
        );

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: controllerEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                  hintText: 'Email'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: controllerPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                  hintText: 'Password'),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          CupertinoButton(
              child: Text('Login'), color: Colors.blue, onPressed: () {
           Login();
          }),


        ],
      ),
    );
  }
}
