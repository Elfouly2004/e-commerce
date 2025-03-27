import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:mrcandy/features/payment/data/model/paymentintent_input_model.dart';
import 'package:mrcandy/features/payment/presentation/controller/payment_cubit.dart';
import 'package:mrcandy/features/payment/presentation/view/thankyou_screen.dart';

import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../carts/presentation/controller/carts_cubit.dart';
import '../payment_scren.dart';
class CustomBottonBlockconcumer extends StatefulWidget {
  const CustomBottonBlockconcumer({super.key, required this.isLoading});
  final bool isLoading;
  @override
  State<CustomBottonBlockconcumer> createState() => _CustomBottonBlockconcumerState();
}

class _CustomBottonBlockconcumerState extends State<CustomBottonBlockconcumer> {
  @override
  Widget build(BuildContext context) {
    return    BlocConsumer<PaymentCubit, PaymentState>(
  listener: (context, state) {
    if(state is Paymentsuccess){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankyouScreen()),
      );
    }

    if(state is Paymentfailure){

      Navigator.pop(context);
      IconSnackBar.show(
            context,
            snackBarType: SnackBarType.alert,
            label: state.errormessage,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: AppColors.Appbar2,
            iconColor: Colors.white,
            maxLines: 2,
          );



      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ${state.errormessage}");
    }

  },
  builder: (context, state) {
    return CustomButton(
      onTap: () async {
        setState(() =>widget. isLoading );

        PaymentintentInputModel paymentintentinputmodel =PaymentintentInputModel(

          amount:" ${context.read<CartsCubit>().totalprice}", currency: 'USD',customerid:'cus_S1HVpjReS4TF6a' );

        BlocProvider.of<PaymentCubit>(context).makepayment(paymentintentinputmodel: paymentintentinputmodel);



        for (var item in context.read<CartsCubit>().cartsList) {
          await BlocProvider.of<CartsCubit>(context)
              .updateCartQuantity(item.id, item.quantity);
        }
        await context.read<CartsCubit>().confirmCartUpdates();
        setState(() => widget.isLoading );
      },
      loading:  state is Paymentloading ?true :false,
      text: "confirm".tr(),
    );
  },
);
  }
}
