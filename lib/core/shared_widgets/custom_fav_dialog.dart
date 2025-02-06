import 'package:flutter/material.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

class FavoriteDialog extends StatelessWidget {
  final bool isAdded;
  final VoidCallback onConfirm;

  const FavoriteDialog({
    Key? key,
    required this.isAdded,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          Icon(
            isAdded ? Icons.check_circle : Icons.remove_circle,
            color: isAdded ? Colors.green : Colors.red,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            isAdded ?  AppTexts.add_done:AppTexts.remove_done ,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            AppTexts.ok,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
