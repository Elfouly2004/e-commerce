class PaymentintentInputModel {
  final String amount;
  final String currency;
  final String customerid;

  PaymentintentInputModel({required this.amount,required this.currency, required this.customerid});

  Map<String, dynamic> toJson() {
    final dividedAmount = (double.parse(amount) / 50).round();

    return {
      'amount': "${dividedAmount}00",
      'currency': currency,
      'customer':customerid
    };
  }
}
