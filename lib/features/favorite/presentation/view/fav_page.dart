import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_lottie.dart';
import '../controller/fav_cubit.dart';
import '../controller/fav_state.dart';
import 'dart:ui' as ui;


Widget buildImage(String imageUrl, double screenWidth) {
  return Container(
    width: screenWidth * 0.3,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 120.h,
        width: 100.w,
        fit: BoxFit.fitHeight,
        errorWidget: (context, url, error) =>
        const Icon(Icons.broken_image, size: 50, color: Colors.red),
      ),
    ),
  );
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override


  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl :ui. TextDirection.ltr,
      child: BlocProvider(
  create: (context) => FavoritesCubit()..fetchFavorites(),
  child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppbar(
            title: 'Fav'.tr(),
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavoritesFailureState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is NoInternetState) {
                    return NoInternetWidget(
                      onRetry: () {
                        context.read<FavoritesCubit>().fetchFavorites();
                      },
                    );
                  } else if (state is FavoritesSuccessState) {
                    final favorites = state.favorites;
                    if (favorites.isEmpty) {

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/Animation - 1739270151606.json',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "المفضله فارغه",
                              style: GoogleFonts.cairo(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context.read<FavoritesCubit>().fetchFavorites();
                      },
                      child: ListView.builder(
                        itemCount: favorites.length,
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          final product = favorites[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final screenWidth = constraints.maxWidth;

                                return Stack(
                                  children: [
                                    Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: AppColors.Appbar2),
                                        color: AppColors.gridproduct,
                                      ),
                                      child: Row(
                                        children: [
                                          if (!isArabic)
                                            buildImage(product.product.image, screenWidth),

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                              child: Column(
                                                crossAxisAlignment: isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          context.read<FavoritesCubit>().deletefav(context, index);
                                                        },
                                                        child: BlocBuilder<FavoritesCubit, FavoritesState>(
                                                          builder: (context, state) {
                                                            final isLoading = context.read<FavoritesCubit>().loadingIndex == index;
                                                            return CircleAvatar(
                                                              radius: 20.r,
                                                              backgroundColor: AppColors.white,
                                                              child: isLoading
                                                                  ? const CircularProgressIndicator()
                                                                  : const Icon(Icons.delete, color: Colors.red),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Text(
                                                        product.product.name.split(",").join(""),
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${product.product.price} ${"eg".tr()}",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.defaultcolor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 0),
                                                  if (product.product.discount > 0)
                                                    Text(
                                                      " ${"offer".tr()}: ${product.product.discount}  %",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w800,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (isArabic)
                                            buildImage(product.product.image, screenWidth),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ),
          ],
        ),
      ),
),
    );
  }


}
