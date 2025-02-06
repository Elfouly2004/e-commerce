import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class SettingItemModel {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;

  SettingItemModel({
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });
}