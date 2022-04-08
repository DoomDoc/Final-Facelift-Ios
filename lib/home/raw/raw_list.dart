// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../models/raw.dart';
import 'raw_page.dart';

class RawList extends StatelessWidget {
  const RawList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RawCard(material: rawMaterialList[0]),
          RawCard(material: rawMaterialList[1]),
          RawCard(material: rawMaterialList[2]),
          RawCard(material: rawMaterialList[3]),
          RawCard(material: rawMaterialList[4]),
        ],
      ),
    );
  }
}

class RawCard extends StatelessWidget {
  final RawMaterial material;
  const RawCard({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RawSceen(material: material)),
        ),
        child: Column(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(65),
                child: Image.asset(material.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                material.name,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
