import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../services/databases.dart';
import 'package:flutter/material.dart';

import '../log_in/welcome.dart';
import '../models/models.dart';
import '../services/auth_service.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  String _currentName = "";
  String _currentEmail = "";
  String _currentCity = "";
  String _currentState = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthClass authClass = AuthClass();
    Future<void> showDeletePopup() async {
      return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Account'),
          content: const Text('Do you really want to Delete your Account?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    await DatabaseService().deleteUser().whenComplete(() async {
                      await DatabaseService().createRequest(
                          "Account Deleted", "$number has deleted his account");
                      await authClass.signOut(context: context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (route) => false,
                      );
                    });
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return StreamBuilder<Uuser>(
      stream: DatabaseService().userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text("My Account",
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black54),
            ),
            body: SafeArea(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      textField(size, snapshot.data!.name, "Name", 1),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Phone Number"),
                            Container(
                              height: 50,
                              width: size.width * 0.65,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text("$number"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      textField(size, snapshot.data!.email, "Email", 2),
                      const SizedBox(height: 20),
                      textField(size, snapshot.data!.city, "City", 3),
                      const SizedBox(height: 20),
                      textField(size, snapshot.data!.state, "State", 4),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => showDeletePopup(),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(32),
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: const Center(
                                      child: Text("Delete Account")),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.025),
                            InkWell(
                              onTap: () async {
                                if (_currentName == "") {
                                  _currentName = snapshot.data!.name;
                                } else {
                                  _currentName = capitalize(_currentName);
                                }
                                if (_currentEmail == "") {
                                  _currentEmail = snapshot.data!.email;
                                }
                                if (_currentCity == "") {
                                  _currentCity = snapshot.data!.city;
                                } else {
                                  _currentCity = capitalize(_currentCity);
                                }
                                if (_currentState == "") {
                                  _currentState = snapshot.data!.state;
                                } else {
                                  _currentState = capitalize(_currentState);
                                }
                                await DatabaseService()
                                    .updateUserProfil(
                                  _currentName,
                                  _currentEmail,
                                  _currentCity,
                                  _currentState,
                                )
                                    .whenComplete(() async {
                                  showAnimatedDialogBox(
                                      context,
                                      "Updated Successfully",
                                      true,
                                      3,
                                      "6.png",
                                      true,
                                      1);
                                });
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(32),
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: const Center(
                                      child: Text("Update Account")),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget textField(Size size, String ini, String text, int current) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          SizedBox(
            height: 50,
            width: size.width * 0.65,
            // width: size.width * 0.65,
            child: TextFormField(
              initialValue: ini,
              decoration: InputDecoration(
                hintText: "Enter $text",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                contentPadding: const EdgeInsets.only(left: 12),
                // enabledBorder: UnderlineInputBorder,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  current == 1
                      ? _currentName = val
                      : current == 2
                          ? _currentEmail = val
                          : current == 3
                              ? _currentCity = val
                              : _currentState = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
