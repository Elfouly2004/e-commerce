import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/payment/presentation/view/widgets/thank_you_card.dart';

import 'custom_check_icon.dart';
import 'custom_dashed_line.dart';

class ThankyouBody extends StatelessWidget {
  const ThankyouBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 20),
      child: Stack(
     clipBehavior: Clip.none,
        children: [




          const ThankyouCard(),


          Positioned(
            bottom: MediaQuery. sizeOf(context) .height *0.2+20,
            left: 20+8,
            right: 20+8,
            child: CustomDachedLine(),
          ),



          Positioned(
            left: -20,
              bottom: MediaQuery. sizeOf(context) .height *0.2,
              child: CircleAvatar(
            backgroundColor: AppColors.white,
          )),

          Positioned(
            right: -20,
              bottom: MediaQuery. sizeOf(context) .height *0.2,
              child: CircleAvatar(
            backgroundColor: AppColors.white,
          )),


          Positioned(
             left: 0,
              right: 0,
              top: -50,
              child: CustomCheckIcon())


        ],
      ),
    );
  }
}



