// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LuxuryElements extends StatelessWidget {
  const LuxuryElements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final images = [
      "assets/luxury/s1.jpg",
      "assets/luxury/s2.JPG",
      "assets/luxury/s3.JPG",
      "assets/luxury/s4.jpg",
      "assets/luxury/s5.JPG",
      "assets/luxury/s6.JPG",
      "assets/luxury/s7.JPG",
      "assets/luxury/s8.JPG",
      "assets/luxury/s9.JPG",
      "assets/luxury/s10.JPG",
      "assets/luxury/s11.JPG",
      "assets/luxury/s12.JPG",
      "assets/luxury/s13.JPG",
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

Widget buildImage(String image, int index) => Image.asset(image);
