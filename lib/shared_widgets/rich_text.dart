import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // استيراد مكتبة Google Fonts

import '../core/utils/app_colors.dart';

class Rich_Text extends StatelessWidget {
  const Rich_Text({super.key, this.onTap, this.text1, this.text2,});
  final void Function()? onTap;
  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: GoogleFonts.almarai(
              color: AppColors.grey,
            ),
          ),
          TextSpan(
            text: text2,
            style: GoogleFonts.almarai(
              color: AppColors.grey,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
