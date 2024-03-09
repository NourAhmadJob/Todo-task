import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  final Color color;
  double? size;
  int? maxLine;
  FontWeight? fontWeight;

  CustomText({super.key, required this.text, this.color = Colors
      .white, this.size = 14.0, this.fontWeight = FontWeight.w400,this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(color: color, fontSize:size, fontWeight:fontWeight,),
    );
  }
}
