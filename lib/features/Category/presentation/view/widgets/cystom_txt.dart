import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class CystomTxt extends StatelessWidget {
  const CystomTxt({
    super.key,
    required this.data,
    required this.fontSize,
    required this.color,
  });

  final String data;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar' ? ui.TextDirection.rtl :ui. TextDirection.ltr,
      child: Text(
        maxLines: 5,
        data,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
