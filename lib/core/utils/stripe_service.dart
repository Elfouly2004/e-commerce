import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mrcandy/core/utils/api_keys.dart';
import 'package:mrcandy/core/utils/api_service.dart';
import '../../features/payment/data/model/ephemeralkey_model.dart';
import '../../features/payment/data/model/initpaymentsheet_model.dart';
import '../../features/payment/data/model/paymentintent_input_model.dart';
import '../../features/payment/data/model/paymentintent_model.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(PaymentintentInputModel paymentIntentInputModel) async {
    final response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: "https://api.stripe.com/v1/payment_intents",
      token: ApiKeys.secretkey,
      Headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer ${ApiKeys.secretkey}',

      }
    );

    print('Stripe API Response: ${response.body}');

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    if (!jsonResponse.containsKey('client_secret') || jsonResponse['client_secret'] == null) {
      throw Exception('Stripe API response missing client_secret: $jsonResponse');
    }

    return PaymentIntentModel.fromJson(jsonResponse);
  }

  Future<void> initPaymentSheet({required InitpaymentsheetModel paymentsheetmodel  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentsheetmodel.clientsecret,
        customerEphemeralKeySecret: paymentsheetmodel.ephemeralkeysecret,
        customerId: paymentsheetmodel.customrid,
        merchantDisplayName: "Abdelrahman",
      ),
    );
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({required PaymentintentInputModel paymentIntentInputModel}) async {

    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralkeymodel = await GreateEphemeralKey(Customerid:paymentIntentInputModel.customerid );

    var initpaymentsheetmodel = InitpaymentsheetModel(
        clientsecret: paymentIntentModel.clientSecret!,
        customrid:paymentIntentInputModel.customerid!,
        ephemeralkeysecret: ephemeralkeymodel.secret!
    );
    await initPaymentSheet(paymentsheetmodel: initpaymentsheetmodel);

    await displayPaymentSheet();
  }







  Future<EphemeralKeyModel> GreateEphemeralKey(
      {
        required String Customerid,
      }
      ) async {
    final response = await apiService.post(
      body: {
        'customer':Customerid
      },
      url: "https://api.stripe.com/v1/ephemeral_keys",
      token: ApiKeys.secretkey,
      Headers: {
        'Authorization': 'Bearer ${ApiKeys.secretkey}',
        'Stripe-Version':'2025-02-24.acacia',
       "Content-Type": "application/x-www-form-urlencoded",

    }
    );

    print('Stripe API Response: ${response.body}');

    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    if (!jsonResponse.containsKey('id') || jsonResponse['id'] == null) {
      throw Exception('Stripe API response missing client_secret: $jsonResponse');
    }

    return EphemeralKeyModel.fromJson(jsonResponse);
  }


}


