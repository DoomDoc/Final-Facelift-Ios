import 'package:facelift_constructions/home/get_premium_button.dart';
import 'package:flutter/material.dart';

class PremiumWidget extends StatelessWidget {
  final bool s;
  const PremiumWidget({
    Key? key,
    required this.size,
    required this.s,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Material(
        elevation: 10,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black87,
            ),
            padding: const EdgeInsets.all(16),
            height: 550,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Premium",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PremiumText(
                        text: """Record daily expenses""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Completion progress""",
                        s: s,
                      ),
                      PremiumText(
                        text: """750+ Material catalogues""",
                        s: s,
                      ),
                      PremiumText(
                        text: """170+ brands""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Live CCTV construction view""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Facelift site supervisor""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Unlimited Labor complaints""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Free Architecture plans""",
                        s: s,
                      ),
                      PremiumText(
                        text: """Free materials delivery""",
                        s: s,
                      ),
                      // PremiumText(
                      //   text: """Pay digitally through app""",
                      //   s: s,
                      // ),
                      PremiumText(
                        text: """Access to international products""",
                        s: s,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: GetPremiumButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumText extends StatelessWidget {
  final String text;

  final bool s;
  const PremiumText({
    Key? key,
    required this.text,
    required this.s,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: s ? 15 : 10,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
