// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GreenSpaces extends StatelessWidget {
  const GreenSpaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final images = [
      "assets/green_spaces/1.jpg",
      "assets/green_spaces/2.jpg",
      "assets/green_spaces/3.jpg",
      "assets/green_spaces/4.jpg",
      "assets/green_spaces/5.jpg",
      "assets/green_spaces/6.jpg",
      "assets/green_spaces/7.jpg",
      "assets/green_spaces/8.jpg",
      "assets/green_spaces/9.jpg",
      "assets/green_spaces/10.jpg",
      "assets/green_spaces/11.jpg",
      "assets/green_spaces/12.jpg",
      "assets/green_spaces/13.jpg",
    ];
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        final image = images[index];
        return buildImage(image, index);
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: 400,
        // height: size.height * 0.45,
        enableInfiniteScroll: false,
        initialPage: 0,
        autoPlay: true,
        autoPlayInterval: Duration(
          milliseconds: 2000,
        ),
      ),
    );
  }
}

Widget buildImage(String image, int index) => Container(
      // margin: EdgeInsets.all(10),
      // color: Colors.blue,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
