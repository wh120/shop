import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Carousel extends StatelessWidget {
  final List<String> imgList ;

  const Carousel({super.key, required this.imgList});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width*0.9,
        child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 0.5
          ),
          items: imgList
              .map((item) => Padding(
            padding: const EdgeInsets.only(right: 4,left: 4),
            child: Container(
              child: Center(
                  child:
                  Image.network(item, fit: BoxFit.cover, width: 500)),
            ),
          ))
              .toList(),
        ));
  }
}