// ignore_for_file: non_constant_identifier_names

import 'package:facelift_constructions/models/room.dart';
import 'package:flutter/material.dart';

import 'rooms_page.dart';

class RoomGrid extends StatelessWidget {
  final bool s;
  const RoomGrid({
    Key? key,
    required this.size,
    required this.s,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowofRoomCard(
          size: size,
          name1: "Living",
          image1: "assets/room/living.gif",
          photos1: living_photos,
          name2: "Bathroom",
          image2: "assets/room/bath.gif",
          photos2: bathroom_photos,
          s: s,
        ),
        const SizedBox(height: 8),
        RowofRoomCard(
          size: size,
          name1: "Bedroom",
          image1: "assets/room/bedroom.gif",
          photos1: bedroom_photos,
          name2: "Kitchen",
          image2: "assets/room/kitchen.gif",
          photos2: kitchen_photos,
          s: s,
        ),
        const SizedBox(height: 8),
        RowofRoomCard(
          name1: "Dressing",
          image1: "assets/room/dressing.jpg",
          photos1: dressing_photos,
          size: size,
          name2: "House front",
          image2: "assets/room/house.jpg",
          photos2: front_photos,
          s: s,
        ),
      ],
    );
  }
}

class RowofRoomCard extends StatelessWidget {
  final bool s;
  final String name1;
  final String name2;
  final String image1;
  final String image2;
  final List<RoomPhotos> photos1;
  final List<RoomPhotos> photos2;
  const RowofRoomCard({
    Key? key,
    required this.size,
    required this.name1,
    required this.name2,
    required this.image1,
    required this.image2,
    required this.photos1,
    required this.photos2,
    required this.s,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoomCard(
          size: size,
          name: name1,
          image: image1,
          photos: photos1,
          s: s,
        ),
        RoomCard(
          size: size,
          name: name2,
          image: image2,
          photos: photos2,
          s: s,
        ),
      ],
    );
  }
}

class RoomCard extends StatelessWidget {
  final String name;
  final String image;
  final bool s;
  final List<RoomPhotos> photos;
  const RoomCard({
    Key? key,
    required this.size,
    required this.name,
    required this.image,
    required this.photos,
    required this.s,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoomScreen(
                    photos: photos,
                    name: name,
                  )),
        ),
        child: SizedBox(
          // height:,
          child: Material(
            elevation: 10,
            shadowColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: s ? size.width * 0.4 : size.width * 0.43,
                      height: s ? size.height * 0.16 : size.height * 0.18,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
