import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../services/auth_service.dart';
import '../constants.dart';
import '../services/databases.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String smsCode = "";
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String newName = "newUser";
  var codeChose = "+91";
  bool vis = false;
  bool isLoading = false;
  List countryCodes = [
    "+1",
    "+20",
    "+52",
    "+60",
    "+62",
    "+63",
    "+65",
    "+66",
    "+81",
    "+84",
    "+880",
    "+91",
    "+92",
    "+94",
    "+95",
    "+960",
    "+968",
    "+971",
    "+972",
    "+974",
    "+977",
    "+98",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    specialIcon(false),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    specialIcon(true),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: size.width * 0.85,
                  child: const Text(
                    "Full Name",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: size.width * 0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20)
                    ],
                    cursorColor: Colors.black,
                    onChanged: (val) => newName = val,
                    decoration: InputDecoration(
                      hintText: "Enter Here...",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 16),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: size.width * 0.85,
                  child: const Text(
                    "Mobile Number",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                textField(size),
                const SizedBox(height: 50),
                Visibility(
                  visible: vis,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        const Text(
                          "Enter 6 digit OTP",
                          style: TextStyle(fontSize: 16),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(visible: vis, child: otpField(size)),
                const SizedBox(height: 40),
                Visibility(
                  visible: vis,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Send OTP again in ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: "00:$start",
                          style: TextStyle(fontSize: 16, color: pinkColor),
                        ),
                        const TextSpan(
                          text: " sec ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Visibility(
                  visible: vis,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            authClass
                                .signInwithPhoneNumber(
                                    verificationIdFinal, smsCode, context)
                                .whenComplete(
                                  () => DatabaseService()
                                      .updateUserProfil(
                                        newName == ""
                                            ? "New User"
                                            : capitalize(newName),
                                        "",
                                        "",
                                        "",
                                      )
                                      .whenComplete(() => isLoading = false),
                                );
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget specialIcon(bool rev) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: rev ? 10 : 6,
            color: pinkColor,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.circle,
            size: rev ? 8 : 8,
            color: pinkColor,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.circle,
            size: rev ? 6 : 10,
            color: pinkColor,
          ),
        ],
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        }
      } else {
        if (mounted) {
          setState(() => start--);
        }
      }
    });
  }

  Widget otpField(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: OTPTextField(
        length: 6,
        width: size.width - 20,
        fieldWidth: 50,
        style: const TextStyle(fontSize: 17),
        otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.grey.shade300,
          borderColor: Colors.white,
        ),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onChanged: (pin) {
          // print("noCompleted: " + pin);
          setState(() {
            smsCode = pin;
          });
        },
        onCompleted: (pin) {},
      ),
    );
  }

  Widget textField(Size size) {
    return SizedBox(
      width: size.width * 0.9,
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 87,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              isExpanded: true,
              value: codeChose,
              items: countryCodes.map(
                (valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                },
              ).toList(),
              onChanged: (newValue) {
                setState(() => codeChose = "$newValue");
              },
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: 50,
            width: size.width * 0.9 - 90,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Cannot be Empty";
                } else if (value.length != 10) {
                  return "Invalid Mobile Number";
                }
                return null;
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Enter Here...",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14, left: 8),
                suffixIcon: InkWell(
                  onTap: wait
                      ? () => showSnackBar(context, "Wait for timer to finish")
                      : () async {
                          showSnackBarDuration(context, "Redirecting...", 5);
                          startTimer();
                          setState(() {
                            start = 30;
                            wait = true;
                            vis = true;
                            buttonName = "Resend";
                          });
                          await authClass.verifyPhoneNumber(
                              "$codeChose ${phoneController.text}",
                              context,
                              setData);
                        },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: Text(
                      buttonName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setData(String verificationId) {
    setState(() => verificationIdFinal = verificationId);
    startTimer();
  }
}
