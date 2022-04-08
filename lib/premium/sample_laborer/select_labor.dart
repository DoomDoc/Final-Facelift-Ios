import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/premium/sample_laborer/complaint_labor.dart';
import 'package:flutter/material.dart';

import '../../services/databases.dart';
import 'sample_laborer_list.dart';

class SelectLaborScreen extends StatelessWidget {
  const SelectLaborScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().userLaborer.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 75,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                title: const Text("Select Labor",
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.black54),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                String name =
                                    snapshot.data!.docs[index]["name"];
                                String skill =
                                    snapshot.data!.docs[index]["skill"];
                                String image =
                                    snapshot.data!.docs[index]["image"];
                                return UserLaborerCard(
                                  name: name,
                                  skill: skill,
                                  image: image,
                                  sample: false,
                                  press: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComplaintsScreen(
                                        name: name,
                                        skill: skill,
                                        image: image,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Image.network(
                          "https://blogger.googleusercontent.com/img/a/AVvXsEi-Q6E5jGOotFKDU1sGRn4J0aNm6NVFD5D9Y0qI8yM0_t_QCgudbgEKaSJeDRh7QEdSwQ4e_CZNjAvhOcGJ7D0PcEZcQfRr3ojf5rjVyv5qte97QDteDw23pyjZhECdHWNC5HTRGB5blI6x4bh5KzpFd5MT8RBJpVNSM_cqdQmXHvWBwfY_Q_EQFqKy=s16000"),
                    )
                  ],
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
