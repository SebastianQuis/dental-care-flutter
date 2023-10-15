import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
          if ( subTitle.isNotEmpty ) 
            Text(subTitle, style: const TextStyle(fontSize: 18),),
        ],
      ),
    );
  }
}