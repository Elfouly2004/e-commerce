
import 'package:dartz/dartz.dart';

import 'package:mrcandy/core/errors/failure.dart';

import 'package:mrcandy/features/payment/data/model/paymentintent_input_model.dart';

import '../../../../core/utils/stripe_service.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpelemntation  implements CheckoutRepo{

  final StripeService stripeService =StripeService();
  @override

  Future<Either<Failure, void>> Makepayment({required PaymentintentInputModel paymentintentinputmodel}) async{


    try{
      await stripeService.makePayment(paymentIntentInputModel: paymentintentinputmodel);
return right(null);
    }
    catch(e){
   return left ( ServiceFailure(message: e.toString()));
    }

  }

}