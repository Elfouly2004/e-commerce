import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mrcandy/features/payment/data/repo/checkout_repo.dart';

import '../../data/model/paymentintent_input_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future makepayment({required PaymentintentInputModel paymentintentinputmodel})async{

    emit(Paymentloading() );


    var data =await checkoutRepo.Makepayment(paymentintentinputmodel: paymentintentinputmodel);

    data.fold(
          (l) =>emit(Paymentfailure(l.message)) ,
          (r) => emit(Paymentsuccess()),
    );
    
    @override
   void onChange(Change<PaymentState>change){
      print(change.toString());
      super.onChange(change);
    }

  }
}
