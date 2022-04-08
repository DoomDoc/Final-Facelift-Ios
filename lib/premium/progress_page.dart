import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    int val1 = 3;
    int val2 = 2;
    int val3 = 1;
    int val4 = 1;
    int val5 = 1;
    int val6 = 1;
    int val7 = 1;
    int val8 = 1;
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<UserProgressModel>(
        stream: DatabaseService().userProgressStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            val1 = snapshot.data!.value1;
            val2 = snapshot.data!.value2;
            val3 = snapshot.data!.value3;
            val4 = snapshot.data!.value4;
            val5 = snapshot.data!.value5;
            val6 = snapshot.data!.value6;
            val7 = snapshot.data!.value7;
            val8 = snapshot.data!.value8;
          }
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title:
                  const Text("Progress", style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black54),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        rowOfCells("Facelift Partnership", val1, size),
                        rowOfCells("Foundation", val2, size),
                        rowOfCells("Walls with Columns and Beams", val3, size),
                        rowOfCells("Lintel/Roof", val4, size),
                        rowOfCells("Flooring", val5, size),
                        rowOfCells("Painting", val6, size),
                        rowOfCells("Kitchen", val7, size),
                        rowOfCells("Bathrooms", val8, size),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget rowOfCells(String name, int level, Size size) {
    bool finnished, constr, next, pending;
    if (level == 1) {
      finnished = false;
      constr = false;
      next = false;
      pending = true;
    } else if (level == 2) {
      finnished = false;
      constr = false;
      next = true;
      pending = false;
    } else if (level == 3) {
      finnished = false;
      constr = true;
      next = false;
      pending = false;
    } else if (level == 4) {
      finnished = true;
      constr = false;
      next = false;
      pending = false;
    } else {
      finnished = false;
      constr = false;
      next = false;
      pending = false;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        height: 90,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width,
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cell(
                    "Finished",
                    const Icon(Icons.check_circle, color: Colors.white),
                    size,
                    progressLime,
                    finnished,
                  ),
                  cell(
                    "Constructing",
                    const Icon(Icons.imagesearch_roller, color: Colors.white),
                    size,
                    pinkColor,
                    constr,
                  ),
                  cell(
                    "Up Next",
                    const Icon(Icons.skip_next, color: Colors.white),
                    size,
                    progressYellow,
                    next,
                  ),
                  cell(
                    "Pending",
                    const Icon(Icons.timelapse, color: Colors.white),
                    size,
                    progressGrey,
                    pending,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cell(String name, Icon icon, Size size, Color color, bool active) {
    return Container(
      height: 60,
      width: size.width * 0.23,
      decoration: BoxDecoration(
        color: active ? color : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
