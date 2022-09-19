import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  final double? width;
  final double marginLeft,
      marginRight,
      marginTop,
      marginBottom,
      paddingLeft,
      paddingRight,
      paddingTop,
      paddingBottom,
      fontSize;
  final String text, fontFamily;
  final int maxLines;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const CustomTextView({
    Key? key,
    this.width,
    this.marginRight = 0.0,
    this.marginBottom = 0.0,
    this.marginTop = 0.0,
    this.marginLeft = 0.0,
    this.paddingRight = 0.0,
    this.paddingBottom = 0.0,
    this.paddingTop = 0.0,
    this.paddingLeft = 0.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black87,
    this.fontFamily = "Mulish",
    this.textAlign = TextAlign.start,
    required this.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        bottom: marginBottom,
        right: marginRight,
      ),
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        bottom: paddingBottom,
        right: paddingRight,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        textScaleFactor: 1.0,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Georgia',
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
