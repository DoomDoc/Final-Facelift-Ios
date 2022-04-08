// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, prefer_const_constructors

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/main.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  Future<void> signOut({required BuildContext context}) async {
    try {
      await _auth.signOut();
      await storage.delete(key: "phone");
      await storage.delete(key: "uid");
      await storage.delete(key: "usercredential");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void storeTokenAndData(
      UserCredential userCredential, BuildContext context) async {
    print("storing token and data");
    await storage.write(
      key: "phone",
      value: userCredential.user?.phoneNumber.toString(),
    );
    print(userCredential.user?.phoneNumber.toString());
    await storage.write(
      key: "uid",
      value: userCredential.user?.uid,
    );
    print(userCredential.user?.uid.toString());
    await storage.write(
      key: "usercredential",
      value: userCredential.toString(),
    );
  }

  Future<String?> getCredential() async {
    return await storage.read(key: "usercredential");
  }

  Future<String?> getUid() async {
    return await storage.read(key: "uid");
  }

  Future<String?> getPhone() async {
    return await storage.read(key: "phone");
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);
      User? user = userCredential.user;
      print(user);
      storeTokenAndData(userCredential, context);
      number = await getPhone();
      // number = "+917973112165";
      // await DatabaseService()
      //     .updateUserData(userrName == "" ? "new user" : userrName);
      await DatabaseService().updateUserData();
      // await DatabaseService().updateUserPremium(null);
      // await DatabaseService()
      //     .updatePremiumPage("name", 0, 0, 0, "valueChose", false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void showSnackBar(BuildContext context, String text) {
  //   final snackBar = SnackBar(content: Text(text));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
