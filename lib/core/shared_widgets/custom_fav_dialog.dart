import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

class FavoriteDialog extends StatefulWidget {
  final bool isAdded;

  const FavoriteDialog({
    Key? key,
    required this.isAdded,
  }) : super(key: key);

  @override
  _FavoriteDialogState createState() => _FavoriteDialogState();
}

class _FavoriteDialogState extends State<FavoriteDialog> {
  double opacity = 0.0; // تبدأ الأنيميشن شفافة

  @override
  void initState() {
    super.initState();

    // تأخير ظهور الأنيميشن
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });

    // إغلاق النافذة بعد 1.5 ثانية
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
        mainAxisSize: MainAxisSize.min, // يجعل العمود بحجم المحتوى فقط
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 800),
            child: Lottie.asset(
              widget.isAdded
                  ? 'assets/animations/Animation - 1739281684788.json' // عند الإضافة
                  : 'assets/animations/Animation - 1739281299669.json', // عند الحذف
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(height: 20), // مسافة بين الأنيميشن والنص
          Text(
            widget.isAdded ? AppTexts.add_done : AppTexts.remove_done,
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
