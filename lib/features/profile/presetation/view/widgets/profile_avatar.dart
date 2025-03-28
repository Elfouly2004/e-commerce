import 'package:flutter/material.dart';
import 'package:mrcandy/core/utils/app_colors.dart';

class ProfileAvatar extends StatelessWidget {

final ImageProvider<Object>? backgroundImage;
  const ProfileAvatar({super.key, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.Appbar3,
          width: 4,
        ),
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: backgroundImage,
      ),
    );
  }
}
