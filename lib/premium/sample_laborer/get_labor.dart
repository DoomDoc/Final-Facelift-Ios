// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../models/labor.dart';

class GetLaborerScreen extends StatelessWidget {
  const GetLaborerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Get Laborer for $premiumName",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            itemCount: labor_list.length,
            itemBuilder: (context, index) => GetLaborerCard(
              labor: labor_list[index],
            ),
          ),
        ),
      ),
    );
  }
}

class GetLaborerCard extends StatelessWidget {
  final Labor labor;
  const GetLaborerCard({
    Key? key,
    required this.labor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        DatabaseService().createRequest("Labor", labor.name);
        // final time = DateTime.now().millisecondsSinceEpoch;
        // if (labor.name == "Tile/Marble Mistri") {
        //   DatabaseService().updateUserRequestLabor(time, true, "marble_mistr");
        // } else {
        //   DatabaseService().updateUserRequestLabor(time, true, labor.name);
        // }
        showSimpleAnimatedDialogBox(context,
            "A ${labor.name} will be apointed at $premiumName", "1.png");
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  // padding: const EdgeInsets.all(16),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(22),
                      child: Image.asset(labor.image, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Text("Get ${labor.name}", style: TextStyle(fontSize: 16))
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 0.1,
              width: size.width * 0.82,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
