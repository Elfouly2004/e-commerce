import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/payment/presentation/view/widgets/thankyou_body.dart';

import '../../../../core/shared_widgets/custom_appbar.dart';

class ThankyouScreen extends StatelessWidget {
  const ThankyouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(
  leading: IconButton(onPressed:  () {
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back_ios_new,color: AppColors.black,)),
),
      body: Transform.translate(
        offset: Offset(0, 30),
          child: ThankyouBody()),
    );
  }
}
