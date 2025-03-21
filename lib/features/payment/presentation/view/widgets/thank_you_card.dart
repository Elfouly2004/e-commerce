import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/utils/app_images.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:mrcandy/features/payment/presentation/view/widgets/payment_info.dart';

import '../../../../../core/utils/app_colors.dart';
import 'cart_info_widget.dart';
class ThankyouCard extends StatelessWidget {
  const ThankyouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
height: 800.h,
      decoration: ShapeDecoration(
          color:  AppColors.Appbar3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          )),
      child: Padding(
        padding: const EdgeInsets.only(top:50+16),
        child: Column(
          children: [

            Text(
              AppTexts.thankyou,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            )  ,

            Text(
              AppTexts.successful,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            )  ,

            const SizedBox(height: 20,),

            PaymentItemInfo(title:AppTexts.date ,value:"1/2/2025" ,),
            PaymentItemInfo(title:AppTexts.time ,value: "10:30 Am" ,),
            PaymentItemInfo(title:AppTexts.to ,value: "Abdelrahman " ,),

          const SizedBox(height: 15,),

            Divider(
              thickness: 2,
              indent: 15.w,
               endIndent: 15.w,
            ),

            const SizedBox(height: 20,),


            PaymentItemInfo(title:AppTexts.Total ,value: r"50$" ,),

            const SizedBox(height: 10,),


            CartInfoWidget(),

            const Spacer(),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                  Container(
                  width:113.w,
                  height: 85.h,
                  decoration: ShapeDecoration(
                      color:  AppColors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2,color: Colors.green),
                          borderRadius: BorderRadius.circular(20)
                      )),
                    child: Center(
                      child: Text(
                        "Paid",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),

                      ),
                    ),

                  ),


                   Icon(FontAwesomeIcons.barcode,size: 60,),



              ],
            ),


            SizedBox(height:(  (MediaQuery. sizeOf(context) .height *0.2+20) /2)-29,)

          ],
        ),
      ),
    );
  }
}


