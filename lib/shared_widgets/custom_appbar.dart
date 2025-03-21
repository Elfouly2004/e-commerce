import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_images.dart';

class Custom_Appbar extends StatelessWidget {
  const Custom_Appbar({super.key, required this.widget, required this.height, required this.topLeft, required this.topRight});
  final Widget widget;
  final double? height;
  final Radius topLeft;
  final Radius topRight;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.05),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(

            colors: [
              AppColors.Appbar1,
              AppColors.Appbar2,
              AppColors.Appbar3,
            ],
            begin: Alignment.topRight,
            end: Alignment.topLeft,
          ),
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent, // Make AppBar background transparent to show the gradient
          elevation: 0, // Remove shadow
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.13,
          title: Center(
            child: Image(
              image: const AssetImage(AppImages.AppLogo),
              height: MediaQuery.sizeOf(context).height * 0.13,
              width: MediaQuery.sizeOf(context).height * 0.13,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft:topLeft,
                  topRight:topRight,
                ),
              ),
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}
