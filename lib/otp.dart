import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ws_firebase_dinesh/singup.dart';

class verificatinOtp extends StatefulWidget {
  final String verificationId;

  const verificatinOtp({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<verificatinOtp> createState() => _verificatinOtpState();
}

class _verificatinOtpState extends State<verificatinOtp> {
  var otpController = TextEditingController();

  void verifyOtp() async {
    String otp = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Singup()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: Text('verify otp'),
              color: Colors.blue,
              onPressed: () {
                verifyOtp();
              })
        ],
      ),
    );
  }
}
