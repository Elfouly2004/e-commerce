import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap,
    this.loading=false
  });
final String text;
final void Function()? onTap;
final bool loading;
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: loading?CircularProgressIndicator(color: AppColors.white,): Text( text,
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
