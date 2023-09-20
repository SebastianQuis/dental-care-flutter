import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TitleSubTitle extends StatelessWidget {
  final String title;
  String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  double vertical;
  double horizontal;

  TitleSubTitle({
    super.key, 
    required this.title, 
    this.subTitle = '', 
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.vertical = 0,
    this.horizontal = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),),
          if ( subTitle.isNotEmpty ) 
            Text(subTitle),
        ],
      ),
    );
  }
}