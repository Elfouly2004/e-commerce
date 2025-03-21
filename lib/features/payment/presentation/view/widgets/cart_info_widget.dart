import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';

class CartInfoWidget extends StatelessWidget {
  const CartInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
      child: Container(
        width:305.w,
        height: 75.h,
        decoration: ShapeDecoration(
            color:  AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [


              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Credit Card \n",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    TextSpan(
                      text: "Mastercard **78 ",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],

                ),

                textAlign: TextAlign.end,


              ),

              const SizedBox(width: 23,),

              Image.asset(
                height: 20,
                width: 32,
                AppImages.mastercard,fit: BoxFit.scaleDown,),



            ],
          ),
        ),
      ),
    );
  }
}
