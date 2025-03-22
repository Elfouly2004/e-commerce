import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    this.isActive=false, required this.image
  });
final bool isActive;
final String image;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width:103.w,
      height: 70.h,
      decoration: ShapeDecoration(
          color:  AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp),
              side: BorderSide(width: 2,color:isActive? AppColors.Appbar3:Colors.grey)
          ),
          shadows: [
            BoxShadow(
                color: isActive? AppColors.Appbar3:Colors.white,
                blurRadius: 4,
                offset: const Offset(0, 0),
                spreadRadius: 0
            )
          ]

      ),

      child: Container(
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),

        ),
        child: Center(
          child: Image.asset(
            image,
            fit: BoxFit.scaleDown,
            height: 24.h,
          ),
        ),
      ),
    );
  }
}
