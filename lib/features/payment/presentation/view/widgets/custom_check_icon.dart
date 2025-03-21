import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.Appbar3,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.green,
        child: Icon(Icons.check,size: 42,color: AppColors.white,),
      ),
    );
  }
}
