import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

class FavoriteDialog extends StatefulWidget {
  final bool isAdded;

  const FavoriteDialog({
    super.key,
    required this.isAdded,
  });

  @override
  _FavoriteDialogState createState() => _FavoriteDialogState();
}

class _FavoriteDialogState extends State<FavoriteDialog> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 800),
            child: Lottie.asset(
              widget.isAdded
                  ? 'assets/animations/Animation - 1739281684788.json'
                  : 'assets/animations/Animation - 1739281299669.json',
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.isAdded ? "add_done".tr() : "remove_done".tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
