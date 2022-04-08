import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

import '../dialogs.dart';
import 'finishing/finishing_list.dart';
import 'lobor/labor_list.dart';
import 'raw/raw_list.dart';
import 'tools/tools_list.dart';
import 'green_spaces.dart';
import 'logo.dart';
import 'luxury_elements.dart';
import 'premium.dart';
import 'rooms/room_grid.dart';

class HomeScreen extends StatelessWidget {
  final bool logedIn;
  const HomeScreen({
    Key? key,
    required this.logedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Logo(size: size),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "House Room Photos",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                RoomGrid(size: size, s: size.width < 330),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
                  child: Text(
                    "Labor",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                LaborList(size: size),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
                  child: Text(
                    "Latest Tools and Machinery",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                ToolsList(size: size),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
                  child: Text(
                    "Don't just live in your home, feel it!",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const LuxuryElements(),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 24, top: 32),
                  child: Text(
                    "Raw Materials",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const RawList(),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 24, top: 32),
                  child: Text(
                    "Finishing Materials",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                FinishingList(size: size),
                premiumUser == false
                    ? PremiumWidget(size: size, s: size.width > 330)
                    : const SizedBox(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Text(
                    "Facelift promotes Green spaces",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const GreenSpaces(),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  height: 50,
                  // decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: Text(
                      "That's all in this section",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
