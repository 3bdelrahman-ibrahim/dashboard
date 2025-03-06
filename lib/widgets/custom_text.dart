import 'package:auto_size_text/auto_size_text.dart';
import 'package:dashboard_example/app/config.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double widthPercentage;
  final double minFontSize;
  /////////////
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  final dynamic text;

  const CustomText(
    this.text, {
    super.key,
    this.widthPercentage = 0.9,
    this.minFontSize = 5,
    /////////////
    this.color,
    this.fontSize = 16,
    this.maxLines = 1,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: getScreenWidth(context) * widthPercentage,
      ),
      child: AutoSizeText(
        text.toString(),
        // softWrap: true,
        style: TextStyle(fontSize: fontSize, color: color),
        minFontSize: minFontSize,

        textAlign: textAlign,
        maxLines: maxLines,
        // overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
