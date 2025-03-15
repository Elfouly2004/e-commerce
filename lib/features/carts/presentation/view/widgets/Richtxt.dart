
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class Richtxt extends StatelessWidget {
  const Richtxt({super.key, required this.txt1, required this.txt2});

  final String txt1;
  final String txt2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: txt1,
            style: GoogleFonts.almarai(
              fontSize: 15.sp,
              color: AppColors.cartdeatils,
            ),
          ),
          TextSpan(
            text: txt2,
            style: GoogleFonts.almarai(
              fontSize: 14.sp,
              color: AppColors.cartresult,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
//${item.quantity}