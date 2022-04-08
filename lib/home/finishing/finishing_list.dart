// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'finishing_page.dart';

class FinishingList extends StatelessWidget {
  const FinishingList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FinishingRow(
          size: size,
          name1: "Flooring",
          name2: "Paints and Polishes",
          image1: "assets/finishing/flooring.jpg",
          image2: "assets/finishing/paint.jpg",
          id1: 0,
          id2: 1,
        ),
        const SizedBox(height: 8),
        FinishingRow(
          size: size,
          name1: "Doors and Accessories",
          name2: "Lighting",
          image1: "assets/finishing/door.jpg",
          image2: "assets/finishing/lighting.jpg",
          id1: 2,
          id2: 3,
        ),
        const SizedBox(height: 8),
        FinishingRow(
          size: size,
          name1: "Kitchen",
          name2: "Bathroom",
          image1: "assets/finishing/kitchen.jpg",
          image2: "assets/finishing/bathroom.jpg",
          id1: 4,
          id2: 5,
        ),
      ],
    );
  }
}

class FinishingRow extends StatelessWidget {
  final String image1;
  final String name1;
  final int id1;
  final String image2;
  final String name2;
  final int id2;
  const FinishingRow({
    Key? key,
    required this.size,
    required this.name1,
    required this.image1,
    required this.id1,
    required this.name2,
    required this.image2,
    required this.id2,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FinishingCard(
          size: size,
          name: name1,
          image: image1,
          id: id1,
        ),
        FinishingCard(
          size: size,
          name: name2,
          image: image2,
          id: id2,
        ),
      ],
    );
  }
}

class FinishingCard extends StatelessWidget {
  final String image;
  final String name;
  final int id;
  const FinishingCard({
    Key? key,
    required this.size,
    required this.name,
    required this.image,
    required this.id,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishingScreen(id: id)),
        ),
        child: Material(
            elevation: 10,
            // shadowColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: size.height * 0.18,
                      width: size.width * 0.43,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: SizedBox(
                    width: size.width * 0.43,
                    child: Text(
                      name,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: size.width < 330 ? 10 : 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
