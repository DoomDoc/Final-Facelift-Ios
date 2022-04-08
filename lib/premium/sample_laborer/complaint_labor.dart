import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../dialogs.dart';

class ComplaintsScreen extends StatelessWidget {
  final String name;
  final String skill;
  final String image;
  const ComplaintsScreen({
    Key? key,
    required this.name,
    required this.skill,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    String reason = "";
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Raise a Complaint",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                backgroundColor: pinkColor,
                radius: 120,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(height: 10),
              Text(name, style: const TextStyle(fontSize: 16)),
              Text(skill),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 150,
                  child: TextFormField(
                    maxLines: 5,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Cannot be Empty";
                    //   }
                    //   return null;
                    // },
                    onChanged: (value) => reason = value,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 0.1),
                      hintText: "Reason For Complaint",
                      contentPadding: const EdgeInsets.only(left: 12, top: 12),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final time = DateTime.now().millisecondsSinceEpoch;
                  DatabaseService()
                      .updateUserComplaint(time, true, name, skill, reason)
                      .whenComplete(() {
                    showSimpleAnimatedDialogBox(
                        context, "Complaint Registerd", "3.png");
                  });
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: pinkColor,
                    ),
                    child: const Center(child: Text("Submit")),
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
