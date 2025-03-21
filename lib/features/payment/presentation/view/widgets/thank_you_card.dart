import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
class ThankyouCard extends StatelessWidget {
  const ThankyouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color:  AppColors.Appbar3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          )),
    );
  }
}
