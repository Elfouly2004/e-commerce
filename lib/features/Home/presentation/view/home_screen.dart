import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import 'widgets/bannerCcarousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,  this.child, this.child2});

  final Widget? child;
  final Widget? child2;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.04),
      child: Stack(
        children: [
           Column(
            children: [
              // النصف الأول مع gradient
              Expanded(
                flex: 2,
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
                  child: child,
                ),
              ),
              
              // النصف الثاني بالأبيض
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.white,
                  child: child2,
                ),
              ),
            ],
          ),
          //  فوق النصين
          Positioned(
            top: 150.h,
            left: 0.0,
            right: 0.0,
            child: const Center(
              child:BannerCarousel(),
            ),
          ),


        ],
      ),
    );
  }
}
