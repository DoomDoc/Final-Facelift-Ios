// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicScreen extends StatefulWidget {
  const UploadPicScreen({Key? key}) : super(key: key);

  @override
  _UploadPicScreenState createState() => _UploadPicScreenState();
}

class _UploadPicScreenState extends State<UploadPicScreen> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;
  bool isLoading = false;

  void showPickerDialogBox(BuildContext context) => showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottom,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose option"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                ListTile(
                  onTap: () {
                    imagePickerFunc();
                    Navigator.pop(context);
                  },
                  title: Text("Gallery"),
                ),
                ListTile(
                  onTap: () {
                    imagePickerCameraFunc();
                    Navigator.pop(context);
                  },
                  title: Text("Camera"),
                ),
              ]),
            ),
          );
        },
      );

  Future imagePickerFunc() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar(context, "No file");
      }
    });
  }

  Future imagePickerCameraFunc() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar(context, "No file");
      }
    });
  }

  Future uploadImage() async {
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$number/profilePic")
        .child("post_$postId");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    // print(downloadUrl);

    await DatabaseService().updateUserProfilePic(downloadUrl).whenComplete(() {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "uploaded");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title:
            Text("Update Profile Pic", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Container(
                    height: 500,
                    width: size.width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration:
                        BoxDecoration(border: Border.all(color: pinkColor)),
                    child: _image != null
                        ? Image.file(_image!)
                        : const Center(
                            child: Text("No Image Uploaded"),
                          ),
                  ),
                ),
                isLoading
                    ? SizedBox(height: 50)
                    : InkWell(
                        onTap: () {
                          showPickerDialogBox(context);
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: Text("Select")),
                        ),
                      ),
                SizedBox(height: 10),
                isLoading
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          if (_image != null) {
                            setState(() {
                              isLoading = true;
                            });
                            uploadImage();
                          } else {
                            showSnackBar(context, "error");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: Text("Upload")),
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
