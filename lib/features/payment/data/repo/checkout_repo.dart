import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/paymentintent_input_model.dart';
abstract class CheckoutRepo {

  Future<Either<Failure , void>> Makepayment(
      {required PaymentintentInputModel paymentintentinputmodel }
      ) ;

}