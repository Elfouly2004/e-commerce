import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
class CustomSettingText extends StatelessWidget {
  const CustomSettingText({super.key, required this.data});
final String data;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text( data,
            style: GoogleFonts.almarai(
              color: AppColors.Categories,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      );
  }
}
