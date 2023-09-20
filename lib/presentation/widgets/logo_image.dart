import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoImage extends StatelessWidget {
  String image;
  final double height;
  
  LogoImage({super.key, required this.height, this.image = 'assets/images/logo.jpeg',});

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.red,
      height: height,
      width: double.infinity,
      child: Image(
        image: AssetImage(image),
        filterQuality: FilterQuality.high,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}