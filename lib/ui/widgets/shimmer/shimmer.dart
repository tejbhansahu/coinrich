import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer(
    {required Size size, double? width, double? height, double radius = 5.0}) {
  return SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[900]!,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
      ),
    ),
  );
}
