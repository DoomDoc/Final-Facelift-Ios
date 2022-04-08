// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/premium/sample_laborer/select_labor.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../models/sample_labor.dart';
import 'get_labor.dart';

class SampleLaborerList extends StatelessWidget {
  const SampleLaborerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().userLaborer.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snapshot.hasData
                          ? snapshot.data!.docs.isNotEmpty
                              ? "$premiumName's Laborers"
                              : "Sample Laborers"
                          : "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetLaborerScreen())),
                      child: Text(
                        "Get Laborer",
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
              SizedBox(
                height: 200,
                child: snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data!.docs[index]["name"];
                          String skill = snapshot.data!.docs[index]["skill"];
                          String image = snapshot.data!.docs[index]["image"];
                          return UserLaborerCard(
                            name: name,
                            skill: skill,
                            image: image,
                            press: () {},
                            sample: false,
                          );
                        })
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sampleLaborList.length,
                        itemBuilder: (context, index) => UserLaborerCard(
                          name: sampleLaborList[index].name,
                          skill: sampleLaborList[index].skill,
                          image: sampleLaborList[index].image,
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetLaborerScreen())),
                          sample: true,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        snapshot.hasData
                            ? snapshot.data!.docs.isNotEmpty
                                ? Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                    return SelectLaborScreen();
                                  }))
                                : showAnimatedDialogBox(
                                    context,
                                    "No Facelift Laborer is working at $premiumName",
                                    true,
                                    3,
                                    "3.png",
                                    true,
                                    2)
                            : () {};
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 10,
                        shadowColor: Colors.white,
                        child: Container(
                          height: 35,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(child: Text("Raise a Complaint")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class UserLaborerCard extends StatelessWidget {
  // final SampleLabor labor;
  final String name;
  final String skill;
  final String image;
  final VoidCallback press;
  final bool sample;
  const UserLaborerCard({
    Key? key,
    required this.name,
    required this.skill,
    required this.image,
    required this.press,
    required this.sample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: press,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: sample
                  ? Image.asset(
                      image,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      image,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: SizedBox(
                width: 140,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 140,
                child: Text(
                  skill,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SampleLaborerCard extends StatelessWidget {
//   final SampleLabor labor;
//   const SampleLaborerCard({
//     Key? key,
//     required this.labor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: GestureDetector(
//         onTap: () => Navigator.push(context,
//             MaterialPageRoute(builder: (context) => GetLaborerScreen())),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 labor.image,
//                 height: 150,
//                 width: 150,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8, left: 16),
//               child: Text(
//                 labor.name,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Text(
//                 labor.skill,
//                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
