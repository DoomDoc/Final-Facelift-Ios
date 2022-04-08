import 'package:facelift_constructions/log_in/phone_auth_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../models/labor.dart';
import '../../services/databases.dart';

class LaborScreen extends StatelessWidget {
  final Labor labor;
  const LaborScreen({Key? key, required this.labor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 65,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Hero(
                  tag: labor.image,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(labor.image)),
                ),
              ),
              Text(
                labor.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  labor.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              InkWell(
                onTap: userLogedIn
                    ? () {
                        DatabaseService().createRequest("Labor", labor.name);

                        showSimpleAnimatedDialogBox(context,
                            "A ${labor.name} will be apointed", "1.png");
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen()));
                      },
                child: Container(
                  height: 45,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: pinkColor,
                  ),
                  child: Center(child: Text("Get ${labor.name}")),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(32),
              //   child: GetPremiumButton(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
