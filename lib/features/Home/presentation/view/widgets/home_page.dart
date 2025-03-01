import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/gridview_product.dart';

import '../../../../../core/shared_widgets/custom_lottie.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../controller/get_banners/get_banners_cubit.dart';
import '../../controller/get_categories/get_categories_cubit.dart';
import '../../controller/get_product/get_product_cubit.dart';
import '../../controller/get_product/get_product_state.dart';
import '../home_screen.dart';
import 'gridview_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';




    double deviceHeight = MediaQuery.of(context).size.height;
    int expandedFlex,  expandedFlex2 ,height, height2 ;

    if (deviceHeight > 1400) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 270;
      height2 = 20;

    }
    else if (deviceHeight > 1340) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 150;
      height2 = 20;

    }
    else  if (deviceHeight > 1000) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 230;
      height2 = 20;

    }
    else if (deviceHeight > 850) {
      // الأجهزة الكبيرة
      expandedFlex = 6;
      expandedFlex2 = 5;
      height = 110;
      height2 = 20;
    }
    else if (deviceHeight >= 800) {
      // الأجهزة المتوسطة
      expandedFlex = 4;
      expandedFlex2 = 4;
      height = 100;
      height2 = 20;
    }
    else if (deviceHeight > 750) {
      // الأجهزة المتوسطة
      expandedFlex = 4;
      expandedFlex2 = 4;
      height = 100;
      height2 = 20;
    }
    else if (deviceHeight > 700) {
      // الأجهزة الصغيرة
      expandedFlex = 1;
      expandedFlex2 = 1;
      height = 50;
      height2 = 0;
    }
    else {
      // الأجهزة الصغيرة جدًا
      expandedFlex = 1;
      expandedFlex2 = 1;
      height = 50;
      height2 = 0;
    }

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  $deviceHeight");

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is NoInternetStates) {
          return NoInternetWidget(
            onRetry: () {
              context.read<ProductsCubit>().fetchproducts();
              context.read<BannersCubit>().fetchBanners();
              context.read<CategoriesCubit>().fetchCategories(context);
            },
          );
        }

      return  HomeScreen(

          child2: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: height.h),

                Align(
                  alignment:isArabic ? Alignment.centerRight: Alignment.centerLeft,
                  child: Text(
                   "Categories".tr(),
                    style: GoogleFonts.almarai(
                      color: AppColors.Categories,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(
                  flex: expandedFlex,
                  child: const CategoriesGrid(),
                ),
                const SizedBox(height: 10,),

                Align(
                  alignment:isArabic ? Alignment.centerRight: Alignment.centerLeft,
                  child: Text(
                    "buy".tr(),
                    style: GoogleFonts.almarai(
                      color: AppColors.Categories,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(
                  flex: expandedFlex2,
                  child: ProductsGrid(),
                ),
              ],
            ),
          ),

          child: Column(
            children: [
              SizedBox(height: height2.h),

              Center(
                child: Image(
                  image: const AssetImage(AppImages.AppLogo),
                  height: MediaQuery.sizeOf(context).height * 0.13,
                  width: MediaQuery.sizeOf(context).height * 0.13,
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}



