import 'package:flutter/material.dart';

import '../../models/labor.dart';
import 'labor_page.dart';

class LaborList extends StatelessWidget {
  const LaborList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          LaborCard(size: size, labor: labor_list[0]),
          LaborCard(size: size, labor: labor_list[1]),
          LaborCard(size: size, labor: labor_list[2]),
          LaborCard(size: size, labor: labor_list[3]),
          LaborCard(size: size, labor: labor_list[4]),
          LaborCard(size: size, labor: labor_list[5]),
          LaborCard(size: size, labor: labor_list[6]),
          LaborCard(size: size, labor: labor_list[7]),
          LaborCard(size: size, labor: labor_list[8]),
          LaborCard(size: size, labor: labor_list[9]),
        ],
      ),
    );
  }
}

class LaborCard extends StatelessWidget {
  final Labor labor;

  const LaborCard({
    Key? key,
    required this.size,
    required this.labor,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LaborScreen(labor: labor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              borderRadius: BorderRadius.circular(22),
              shadowColor: Colors.white,
              elevation: 10,
              child: SizedBox(
                // width: size.width * 0.53,
                // height: size.height * 0.15,
                width: 200,
                height: 125,
                child: Hero(
                  tag: labor.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      labor.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(labor.name),
          ),
        ],
      ),
    );
  }
}
