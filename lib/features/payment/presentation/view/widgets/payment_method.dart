import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_images.dart';
import 'package:mrcandy/features/payment/presentation/view/widgets/payment_method_item.dart';
class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override

  final List<String> paymentphoto =[
    AppImages.visa,
    AppImages.paypal,
  ];
  int activeindex=0;
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentphoto.length,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              activeindex=index;
              setState(() {

              });
            },
            child: PaymentMethodItem(
              image: paymentphoto[index],
              isActive: activeindex==index,
            ),
          ),
        );
      },),
    );
  }
}
