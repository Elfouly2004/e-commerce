import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/payment/presentation/view/widgets/custom_payment_body.dart';

import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_button.dart';

class PaymentScren extends StatefulWidget {
  const PaymentScren({super.key});

  @override
  State<PaymentScren> createState() => _PaymentScrenState();
}

class _PaymentScrenState extends State<PaymentScren> {
  final GlobalKey<FormState> formkey=GlobalKey();
AutovalidateMode autovalidateMode=AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppbar(
          title: 'payment'.tr(),
        ),
      ),

body: CustomScrollView(
    slivers:[

       SliverToBoxAdapter(
       child: CustomPaymentBody(formkey: formkey,autovalidateMode: autovalidateMode,)

        ),

      SliverFillRemaining(
        hasScrollBody: false,
      child:Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CustomButton(
            onTap: () async {
if (formkey.currentState!.validate()){
  formkey.currentState!.save();
}else{
  autovalidateMode=AutovalidateMode.always;
  setState(() {

  });
}

            }, text: "confirm".tr(),),
        ),
      ),),


]

),
    );
  }
}
