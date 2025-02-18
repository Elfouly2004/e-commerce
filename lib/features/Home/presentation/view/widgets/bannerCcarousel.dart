import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../controller/get_banners/get_banners_cubit.dart';
import '../../controller/get_banners/get_banners_state.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    int height, height2, width;
    double dotHeight, dotWidth;

    if (deviceHeight > 1500) {
      height = 400;
      width = 750;
      height2 = 400;
      dotHeight = 10;
      dotWidth = 10;
    }
    else if (deviceHeight > 1000) {
      height = 250;
      width = 550;
      height2 = 300;
      dotHeight = 10;
      dotWidth = 10;
    }
    else if (deviceHeight > 850) {
      height = 180;
      width = 300;
      height2 = 80;
      dotHeight = 8;
      dotWidth = 8;
    }
    else if (deviceHeight >= 800) {
      height = 160;
      width = 300;
      height2 = 80;
      dotHeight = 8;
      dotWidth = 8;
    }
    else if (deviceHeight > 750) {
      height = 160;
      width = 300;
      height2 = 80;
      dotHeight = 8;
      dotWidth = 8;
    }
    else if (deviceHeight > 700) {
      height = 140;
      width = 300;
      height2 = 90;
      dotHeight = 8;
      dotWidth = 8;
    }
    else {
      height = 130;
      height2 = 40;
      width = 270;
      dotHeight = 5;
      dotWidth = 5;
    }

    return BlocBuilder<BannersCubit, BannersStates>(
      builder: (context, state) {
        if (state is BannersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BannersFailureState) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state is BannersSuccessState) {
          final banners = BannersCubit.get(context).banners;
          return banners.isEmpty
              ? const Center(child: Text("No banners available"))
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: height.h,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: banners.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: width.w,
                        height: height2.h,
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: banner.urlImage,
                          fit: BoxFit.fill,
                          // placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // مؤشر التحميل
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                        ),
                      );

                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 15.h),
              AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: banners.length,
                effect: ExpandingDotsEffect(
                  dotHeight: dotHeight,
                  dotWidth: dotWidth,
                  activeDotColor: AppColors.Appbar2,
                  dotColor: Colors.grey,
                ),
              ),
            ],
          );
        }
        return const Center(child: Text("Unknown state"));
      },
    );
  }
}
