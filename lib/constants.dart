// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home/home_page.dart';
import 'premium/premium_page.dart';
import 'profile/profile_page.dart';

var pinkColor = const Color(0xFFFF72B9);
var progressLime = const Color(0xFF92D050);
var progressYellow = const Color(0xFFFFC000);
var progressGrey = Colors.grey.shade400;
var premiumUser = false;
var iindex = 1;
var valueChose;
var stateChose;
var premiumName = "";
var premiumCity = "";
var houseWidth = 0;
var houseLength = 0;
var houseSize = houseWidth * houseLength;
var userLogedIn = false;
var userName = "";
var userMobile = 0;
String? number = "0";
String userrName = "";
var screens = [
  const PofileScreen(),
  const HomeScreen(logedIn: true),
  const PremiumScreen()
];
bool crossClick = false;

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

commaNumber(int n) {
  var f = NumberFormat("##,##,###", "en_US").format(n);
  return f;
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBarDuration(BuildContext context, String text, int dur) {
  final snackBar =
      SnackBar(content: Text(text), duration: Duration(seconds: dur));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
