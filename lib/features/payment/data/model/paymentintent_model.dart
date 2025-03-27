class PaymentIntentModel {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final AmountDetails amountDetails;
  final int amountReceived;
  final bool automaticPaymentMethodsEnabled;
  final String? captureMethod;
  final String clientSecret;
  final String confirmationMethod;
  final int created;
  final String currency;
  final String? status;
  final List<String> paymentMethodTypes;

  PaymentIntentModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountDetails,
    required this.amountReceived,
    required this.automaticPaymentMethodsEnabled,
    this.captureMethod,
    required this.clientSecret,
    required this.confirmationMethod,
    required this.created,
    required this.currency,
    this.status,
    required this.paymentMethodTypes,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      amountCapturable: json['amount_capturable'],
      amountDetails: json['amount_details'] != null
          ? AmountDetails.fromJson(json['amount_details'])
          : AmountDetails(tip: {}),
      amountReceived: json['amount_received'],
      automaticPaymentMethodsEnabled: json['automatic_payment_methods']?['enabled'] ?? false,
      captureMethod: json['capture_method'],
      clientSecret: json['client_secret'],
      confirmationMethod: json['confirmation_method'],
      created: json['created'],
      currency: json['currency'],
      status: json['status'],
      paymentMethodTypes: List<String>.from(json['payment_method_types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'amount': amount,
      'amount_capturable': amountCapturable,
      'amount_details': amountDetails.toJson(),
      'amount_received': amountReceived,
      'automatic_payment_methods': {'enabled': automaticPaymentMethodsEnabled},
      'capture_method': captureMethod,
      'client_secret': clientSecret,
      'confirmation_method': confirmationMethod,
      'created': created,
      'currency': currency,
      'status': status,
      'payment_method_types': paymentMethodTypes,
    };
  }
}

class AmountDetails {
  final Map<String, dynamic> tip;

  AmountDetails({required this.tip});

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      tip: json['tip'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tip': tip,
    };
  }
}
