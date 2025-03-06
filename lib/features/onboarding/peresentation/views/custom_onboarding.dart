import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/shared_widgets/custom_fav_dialog.dart';
import 'package:mrcandy/core/utils/app_images.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../login/presentation/view/Login.dart';
import '../../data/model/slider_model.dart';
import 'dart:ui'as ui;
class Sliderpage extends StatefulWidget {
  const Sliderpage({super.key});

  @override
  State<Sliderpage> createState() => _SliderpageState();
}

class _SliderpageState extends State<Sliderpage> {
  late PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(); // Remove reverse here
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(AppImages.slider),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection:
                      isArabic ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                      child: PageView.builder(
                        itemCount: sliders.length,
                        controller: _controller,
                        reverse: !isArabic,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 90.h),
                              Center(
                                child: Image(
                                  image: AssetImage(sliders[index].image),
                                  width: 200.w,
                                  height: 300.h,
                                ),
                              ),
                              SizedBox(height: 200.h),
                              Text(
                                sliders[index].title,
                                style: GoogleFonts.almarai(
                                  textStyle: const TextStyle(
                                    color: AppColors.title,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Slider_des".tr(),
                                style: GoogleFonts.almarai(
                                  textStyle: const TextStyle(
                                    color: AppColors.des,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 50.h),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: isArabic ? ui.TextDirection.ltr : ui.TextDirection.ltr,
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: sliders.length,
                      effect: const ScaleEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        dotColor: Colors.grey,
                        activeDotColor: AppColors.selectDot,
                      ),
                    ),
                  ),

                  SizedBox(height: 50.h),
                  InkWell(
                    onTap: () {
                      if (currentIndex == sliders.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      } else {
                        _controller.animateToPage(
                          currentIndex + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Container(
                      width: 164.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.Buttongradient4,
                            AppColors.Buttongradient3,
                            AppColors.Buttongradient1,
                            AppColors.Buttongradient2,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          sliders[currentIndex].buttonText,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            height: 100,
            left: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text(
                "تخطي",
                style: TextStyle(fontSize: 15, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


