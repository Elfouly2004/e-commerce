import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../payment/presentation/view/payment_scren.dart';
import '../../../../payment/presentation/view/widgets/custom_botton_blockconsumer.dart';
import '../../../../payment/presentation/view/widgets/payment_method.dart';
import '../../controller/carts_cubit.dart';
class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({super.key, required this.isLoading});
final   bool isLoading ;

  @override
  State<PaymentMethodBottomSheet> createState() => _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const PaymentMethod(),
          const SizedBox(height: 32),


          CustomBottonBlockconcumer(isLoading: widget.isLoading,)

        ],
      ),
    );
  }
}


