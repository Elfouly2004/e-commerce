import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/Animation - 1739268679606.json', height: 200),
          SizedBox(height: 20),
          Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry, // تمرير الدالة المطلوبة
            child: Text("إعادة المحاولة"),
          ),
        ],
      ),
    );
  }
}
