import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/premium/new_premium_user.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../dialogs.dart';
import '../models/models.dart';
import 'progress_page.dart';
import 'sample_bill/sample_bills_list.dart';
import 'sample_laborer/sample_laborer_list.dart';
import 'superviser_widget.dart';
import 'user_house_plan/plan_list.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (premiumUser) {
      return StreamBuilder<PremiumDataModel>(
        stream: DatabaseService().userPrmiumDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            premiumName = snapshot.data!.houseName;
            premiumCity = snapshot.data!.city;
            return WillPopScope(
              onWillPop: () => showExitPopup(context),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            snapshot.data!.houseName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data!.area} Sq Ft",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: pinkColor),
                        ),
                        const SizedBox(height: 30),
                        const HousePlansList(),
                        const Superviser(),
                        const SampleLaborerList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Progress",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProgressScreen()));
                                },
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: pinkColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<UserProgressModel>(
                            stream: DatabaseService().userProgressStream,
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CircularProgressIndicator(
                                          value: snapshot.hasData
                                              ? snapshot.data!.overAllvalue
                                              : 0.07,
                                          valueColor:
                                              AlwaysStoppedAnimation(pinkColor),
                                          strokeWidth: 20,
                                          backgroundColor: Colors.grey[400],
                                        ),
                                        Center(
                                          child: Text(snapshot.hasData
                                              ? "${snapshot.data!.percentage}%"
                                              : "7%"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                        const SampleBillsList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Live CCTV",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Coming Soon",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: pinkColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return const NewPrimiumUserScreen();
    }
  }
}
