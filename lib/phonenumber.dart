import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ws_firebase_dinesh/otp.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  var phoneNoController = TextEditingController();



  void sendOtp() async {
    String phone =   "+91" + phoneNoController.text.trim();
    print(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => verificatinOtp(
            verificationId: verificationId,
          )));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
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
              controller: phoneNoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              hintText: 'Number'),
            ),
          ),
          SizedBox(height: 20,),
          CupertinoButton(
              child: Text('verify otp'),
              color: Colors.blue,
              onPressed: () {sendOtp();
              })
        ],
      ),
    );
  }
}
