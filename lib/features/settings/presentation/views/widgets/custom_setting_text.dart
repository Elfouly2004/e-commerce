import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomSettingText extends StatelessWidget {
  const CustomSettingText({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left;
    Alignment alignment = context.locale.languageCode == 'ar' ? Alignment.centerRight : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Align(
        alignment: alignment,
        child: Text(
          data,
          style: GoogleFonts.almarai(
            color: AppColors.Categories,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: textAlign,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
