import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  var emailCont = TextEditingController();
  var passCont = TextEditingController();
  var cpassCont = TextEditingController();



  void Singup() async {
    String email = emailCont.text.trim();
    String Password = passCont.text.trim();
    String cpassword = cpassCont.text.trim();

    if (email == "" || Password == "" || cpassword == "") {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('fill all the credentials !'),
        );
      }
      );
    }

    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: Password);
        if (userCredential.user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }
      } on FirebaseAuthException catch (ex) {
        showDialog(context: context, builder: (BuildContext context) {
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
        title: Text('Wel Come'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: emailCont,
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
                keyboardType: TextInputType.visiblePassword,
                controller: passCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)),
                    hintText: 'Passwprd'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: cpassCont,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)),
                    hintText: 'Confirm Password'),
              ),
            ),
            SizedBox(height: 25,),

            CupertinoButton(
                child: Text('Singup'), color: Colors.blue, onPressed: () {
              Singup();
            })
          ],
        ),
      ),
    );
  }
}
