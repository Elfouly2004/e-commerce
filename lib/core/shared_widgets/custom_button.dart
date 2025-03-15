import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap});
final String text;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: 320.w,
        height: 60.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.Appbar3 ,
              AppColors.Appbar2,
              AppColors.Appbar1 ,


            ],
            begin: Alignment.topLeft, // بداية التدرج
            end: Alignment.bottomRight, // نهاية التدرج
          ),
          borderRadius: BorderRadius.circular(15.r), // الزوايا المستديرة
        ),
        child: Center(
          child: Text( text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
