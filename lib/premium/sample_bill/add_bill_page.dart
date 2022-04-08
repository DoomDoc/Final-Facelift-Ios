import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../models/models.dart';
import '../../services/databases.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({Key? key}) : super(key: key);

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;
  String name = "";
  int? amount;
  int? finalAmount;
  int? currentAmount;
  int? warranty = 0;
  bool isLoading = false;
  int _currentDate = 0;
  int _currentMonth = 0;
  int _currentYear = 0;
  int _userDate = 0;
  int _userMonth = 0;
  int _userYear = 0;
  final _formKey = GlobalKey<FormState>();

  void showPickerDialogBox(BuildContext context) => showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottom,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose option"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                ListTile(
                  onTap: () {
                    imagePickerFunc();
                    Navigator.pop(context);
                  },
                  title: const Text("Gallery"),
                ),
                ListTile(
                  onTap: () {
                    imagePickerCameraFunc();
                    Navigator.pop(context);
                  },
                  title: const Text("Camera"),
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
    if (_image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("$number/houseBills")
          .child("post_$postId");
      await ref.putFile(_image!);
      downloadUrl = await ref.getDownloadURL();
    }
    // print(downloadUrl);

    await DatabaseService().updateUserHouseBillAmount(finalAmount);

    await DatabaseService()
        .updateUserHouseBill(
      capitalize(name),
      amount,
      warranty,
      downloadUrl,
      _currentDate,
      _currentMonth,
      _currentYear,
      _userDate,
      _userMonth,
      _userYear,
    )
        .whenComplete(() {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "uploaded");
      Navigator.pop(context);
    });
  }

  addBill(BuildContext context) {
    final now = DateTime.now();
    _currentDate = now.day;
    _currentMonth = now.month;
    _currentYear = now.year;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      uploadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Add a Bill", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16, left: 32, bottom: 8),
                child: Text(
                  "Name of Bill",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Name Cannot be Empty";
                      } else if (value == "") {
                        return "Name Cannot be Empty";
                      }
                      return null;
                    },
                    onChanged: (val) => setState(() {
                      name = val;
                    }),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 0.1),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Cement, Pipes e.t.c.",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12),
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
              const SizedBox(
                height: 16,
              ),
              StreamBuilder<UserAmountModel>(
                  stream: DatabaseService().userAmountStream,
                  builder: (context, snapshot) {
                    snapshot.hasData
                        ? currentAmount = snapshot.data!.total
                        : currentAmount = 0;
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 16, left: 32, bottom: 4),
                              child: Text(
                                "Amount",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: SizedBox(
                                height: 40,
                                width: size.width * 0.4,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Cannot be Empty";
                                    } else if (value == "") {
                                      return "Cannot be Empty";
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(7),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (val) => setState(() {
                                    if (val == "") {
                                      val = "0";
                                    }
                                    amount = int.parse(val);
                                    finalAmount = amount! + currentAmount!;
                                  }),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 0.1),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    hintText: "Rs 12,500",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                    contentPadding: const EdgeInsets.only(left: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black12),
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 16, left: 32, bottom: 4),
                              child: Text(
                                "Warranty",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: SizedBox(
                                height: 40,
                                width: size.width * 0.4,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(2),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (val) => setState(() {
                                    if (val == "") {
                                      val = "0";
                                    }
                                    warranty = int.parse(val);
                                  }),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 0.1),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    hintText: "5 yrs",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                    contentPadding: const EdgeInsets.only(left: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black12),
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
                          ],
                        )
                      ],
                    );
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 48, left: 32, bottom: 16),
                child: Text(
                  "Upload Bill",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    showPickerDialogBox(context);
                  },
                  child: Container(
                    height: 200,
                    // width: size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: _image != null
                          ? Image.file(_image!)
                          : const Text("Add Image"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 4),
                          child: Text(
                            "Date",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: size.width * 0.2,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (val) => setState(() {
                              if (val == "") {
                                val = "00";
                              }
                              _userDate = int.parse(val);
                            }),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "08",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.only(left: 12),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12, bottom: 4),
                            child: Text(
                              "Month",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: size.width * 0.2,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (val) => setState(() {
                                if (val == "") {
                                  val = "00";
                                }
                                _userMonth = int.parse(val);
                              }),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 0.1),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: "11",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                contentPadding: const EdgeInsets.only(left: 12),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 4),
                          child: Text(
                            "Year",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: size.width * 0.2,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (val) => setState(() {
                              if (val == "") {
                                val = "0000";
                              }
                              _userYear = int.parse(val);
                            }),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "2022",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.only(left: 12),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              addBill(context);
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(32),
                              elevation: 10,
                              shadowColor: Colors.white,
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: pinkColor,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: const Center(child: Text("Add Bill")),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
