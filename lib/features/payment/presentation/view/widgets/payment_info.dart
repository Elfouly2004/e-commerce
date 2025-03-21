import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class PaymentItemInfo extends StatelessWidget {
  const PaymentItemInfo({
    super.key, required this.title, required this.value,
  });

  final String title,value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize:18 ,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),


          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          )  ,

        ],
      ),
    );
  }
}
