import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'constants.dart';
import 'main.dart';
import 'premium/sample_laborer/get_labor.dart';

Future<bool> showExitPopup(BuildContext context) async {
  Size size = MediaQuery.of(context).size;
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Exit App'),
          content: const Text('Do you really want to exit?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Center(
                          child: Text('Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ) ??
      false;
}

void showImageDialogBox(BuildContext context, String image, bool net) =>
    showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 400),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 12, right: 12, bottom: 12),
                  child: net ? Image.network(image) : Image.asset(image),
                )
              ],
            ),
          ),
        );
      },
    );

Future<void> showSimpleAnimatedDialogBox(
    BuildContext context, String name, String image) async {
  showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(true);
      });
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/modals/$image",
                      )),
                ),
              ),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: true,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.linear,
    duration: const Duration(milliseconds: 400),
  );
}

Future<void> showAnimatedDialogBox(BuildContext context, String name,
    bool barier, int duration, String image, bool cross, int n) async {
  showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: duration), () {
        Navigator.of(context).pop(true);
        n != 1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const GetLaborerScreen())))
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const MyApp())),
                (route) => false,
              );
      });
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: cross ? 10 : 0),
              cross
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop(true);
                              n != 1
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const GetLaborerScreen())))
                                  : Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const MyApp())),
                                      (route) => false,
                                    );
                            },
                            child: const Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/modals/$image",
                      )),
                ),
              ),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: barier ? true : false,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.linear,
    duration: const Duration(milliseconds: 400),
  );
}
