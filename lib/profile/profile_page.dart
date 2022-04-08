import 'package:facelift_constructions/log_in/welcome.dart';
import 'package:facelift_constructions/profile/accounts_page.dart';
import 'package:facelift_constructions/profile/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../dialogs.dart';
import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/databases.dart';
import 'pic_menu.dart';

class PofileScreen extends StatefulWidget {
  const PofileScreen({Key? key}) : super(key: key);

  @override
  State<PofileScreen> createState() => _PofileScreenState();
}

class _PofileScreenState extends State<PofileScreen> {
  _launchUrl(String siteUrl) async {
    final url = siteUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AuthClass authClass = AuthClass();

    Future<void> showLogoutPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Log out'),
          content: const Text('Do you really want to Logout?'),
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
                    await authClass.signOut(context: context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                      (route) => false,
                    );
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
            return WillPopScope(
              onWillPop: () => showExitPopup(context),
              child: Scaffold(
                backgroundColor: const Color(0xffebebeb),
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const ProfilePic(),
                        const SizedBox(height: 20),
                        Text("Hi ${snapshot.data!.name},"),
                        const SizedBox(height: 20),
                        ProfileMenu(
                          name: "My Account",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AccountsScreen()));
                          },
                          isTrue: false,
                        ),
                        ProfileMenu(
                          name: "Contact",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactScreen()));
                          },
                          isTrue: false,
                        ),
                        ProfileMenu(
                          name: "FAQs & How to use",
                          press: () {
                            _launchUrl(
                                'https://www.facelift.construction/faqs');
                          },
                          isTrue: false,
                        ),
                        ProfileMenu(
                          name: "Log Out",
                          press: () {
                            showLogoutPopup();
                          },
                          isTrue: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
