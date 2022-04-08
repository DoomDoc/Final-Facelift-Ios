import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../dialogs.dart';
import '../../models/sample_plans.dart';
import 'user_house_plan_page.dart';

class HousePlansList extends StatelessWidget {
  const HousePlansList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().userHousePlan.snapshots(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      snapshot.hasData
                          ? snapshot.data!.docs.isNotEmpty
                              ? "$premiumName's House Plans"
                              : "Sample House Plans"
                          : "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserHousePlanScreen())),
                    child: Text(
                      "Add Plan",
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
              height: 275,
              child: snapshot.hasData
                  ? snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String name =
                                snapshot.data!.docs[index]["name"] ?? "name";
                            String url = snapshot.data!.docs[index]["image"] ??
                                "https://images.unsplash.com/photo-1544526226-d4568090ffb8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&w=1000&q=80";
                            return UserHousePlanCard(
                              name: name,
                              image: url,
                              sample: false,
                            );
                          },
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sampleHousePlansList.length,
                          itemBuilder: (context, index) => UserHousePlanCard(
                            name: sampleHousePlansList[index].name,
                            image: sampleHousePlansList[index].image,
                            sample: true,
                          ),
                        )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }
}

class UserHousePlanCard extends StatelessWidget {
  // final SampleHousePlans plan;
  final String name;
  final String image;
  final bool sample;
  const UserHousePlanCard({
    Key? key,
    required this.name,
    required this.image,
    required this.sample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          sample
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserHousePlanScreen()))
              : showImageDialogBox(context, image, true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: sample
                    ? Image.asset(
                        image,
                        height: 235,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        image,
                        height: 235,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8),
              child: SizedBox(
                width: 140,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class HousePlanCard extends StatelessWidget {
//   final SampleHousePlans plan;
//   const HousePlanCard({
//     Key? key,
//     required this.plan,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: GestureDetector(
//         onTap: () => Navigator.push(context,
//             MaterialPageRoute(builder: (context) => UserHousePlanScreen())),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Material(
//               borderRadius: BorderRadius.circular(16),
//               elevation: 10,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(
//                   plan.image,
//                   height: 235,
//                   width: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child: Text(
//                 plan.name,
//                 style: TextStyle(fontSize: 12),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
