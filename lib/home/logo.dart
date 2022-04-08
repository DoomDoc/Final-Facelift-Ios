import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
          child: Material(
            elevation: 10,
            // shadowColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: size.height * 0.1,
              // width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
        )
      ],
    );
  }
}
