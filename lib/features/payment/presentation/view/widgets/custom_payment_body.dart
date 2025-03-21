import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../../core/shared_widgets/custom_button.dart';
class CustomPaymentBody extends StatefulWidget {
  const CustomPaymentBody({super.key, required this.formkey, required this.autovalidateMode});
final  GlobalKey<FormState> formkey;
final  AutovalidateMode autovalidateMode;
  @override
  State<CustomPaymentBody> createState() => _CustomPaymentBodyState();
}

class _CustomPaymentBodyState extends State<CustomPaymentBody> {

  String cardNumber="",expiryDate="",cardHolderName="",cvvCode="";
  bool showBackView =false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CreditCardWidget(
          cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            onCreditCardWidgetChange: (p0) {

            },),

        CreditCardForm(
          autovalidateMode: widget.autovalidateMode,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          onCreditCardModelChange: (CreditCardModel data) {
            setState(() {
              cardNumber = data.cardNumber;
              expiryDate = data.expiryDate;
              cardHolderName = data.cardHolderName;
              cvvCode = data.cvvCode;
              showBackView = data.isCvvFocused;
            });
          },
          formKey: widget.formkey,
        ),




      ],
    );
  }
}
