import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dialogs.dart';
import '../services/databases.dart';
import '../constants.dart';

class NewPrimiumUserScreen extends StatefulWidget {
  const NewPrimiumUserScreen({Key? key}) : super(key: key);

  @override
  _NewPrimiumUserScreenState createState() => _NewPrimiumUserScreenState();
}

class _NewPrimiumUserScreenState extends State<NewPrimiumUserScreen> {
  List dropDownItems = [
    "New House",
    "Renovation",
    "Not a house",
    "Something else"
  ];
  List statesItems = [
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh ",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Dehli",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Other",
  ];

  final _formKey = GlobalKey<FormState>();
  final _height = 60.0;
  // bool isError = false;
  moveToNextScreen(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        iindex = 2;
      });
      // showSimpleAnimatedDialogBox(context, "name", 3, "2.png");
      showAnimatedDialogBox(
          context, "Congratulations!", false, 3, "2.png", false, 1);
      await DatabaseService().updateUserPremium(true);
      await DatabaseService().updateUserProgress();
      await DatabaseService().updateUserPremiumData(
        capitalize(premiumName),
        houseLength,
        houseWidth,
        houseSize,
        valueChose,
        capitalize(premiumCity),
        stateChose,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (premiumUser == false) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text("Fill the form",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                  child: Text(
                    "Give a Name to Your Home",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: _height,
                    width: size.width * 0.9,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name Cannot be Empty";
                        }
                        return null;
                      },
                      onChanged: (value) => premiumName = value,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(fontSize: 0.1),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Ex-Villa 41, Vig residence, Mannat, e.t.c.",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                        contentPadding: const EdgeInsets.only(left: 12),
                        // enabledBorder: UnderlineInputBorder,
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
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, bottom: 16),
                  child: Text(
                    "Size",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: _height,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _height,
                          width: size.width * 0.2,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Rquired";
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                value == ""
                                    ? houseLength = 0
                                    : houseLength = int.parse(value);
                                houseSize = houseWidth * houseLength;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              hintText: "Front",
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              // border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 0),
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
                        const Text("ft"),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("X"),
                        ),
                        SizedBox(
                          height: _height,
                          width: size.width * 0.2,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Requred";
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                value == ""
                                    ? houseWidth = 0
                                    : houseWidth = int.parse(value);
                                houseSize = houseWidth * houseLength;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              hintText: "Back",
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 0),
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
                        const Text("ft"),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "=",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: _height,
                          width: size.width * 0.25,
                          child: TextFormField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              hintText:
                                  houseSize != 0 ? houseSize.toString() : "0",
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 0),
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
                        const Text("sq ft"),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, bottom: 16),
                  child: Text(
                    "Type of Constuction",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: _height,
                    child: DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Requred";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(fontSize: 0.1),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
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
                      isExpanded: true,
                      hint: Text(
                        "Select",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      value: valueChose,
                      items: dropDownItems.map(
                        (valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() => valueChose = newValue);
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, bottom: 16),
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: _height,
                          width: size.width * 0.4,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "req";
                              } else {}
                              return null;
                            },
                            onChanged: (value) => premiumCity = value,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade200,
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade500),
                              filled: true,
                              hintText: "City or Area",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: size.width * 0.45,
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return "Requred";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              errorStyle: const TextStyle(fontSize: 0.1),
                              fillColor: Colors.grey.shade100,
                              filled: true,
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
                            isExpanded: true,
                            hint: Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            value: stateChose,
                            items: statesItems.map(
                              (valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              },
                            ).toList(),
                            onChanged: (newValue) {
                              setState(() => stateChose = newValue);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          moveToNextScreen(context);
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(32)),
                            child: const Center(
                              child: Text(
                                "Get Premium",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              "Alredy a Premium Customer",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }
  }
}
