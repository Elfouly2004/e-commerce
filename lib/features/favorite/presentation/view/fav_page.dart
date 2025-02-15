import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_lottie.dart';
import '../../../Home/presentation/controller/get_product/get_product_state.dart';
import '../controller/fav_cubit.dart';
import '../controller/fav_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SizedBox(
            height: 111.h, // نفس ارتفاع الـ AppBar
            child: const CustomAppbar(title: AppTexts.Fav),
          ),


          Expanded(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is FavoritesFailureState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                else if (state is NoInternetState) {
                  return NoInternetWidget(
                    onRetry: () {
                      context.read<FavoritesCubit>().fetchFavorites();
                    },
                  );
                }
                else if (state is FavoritesSuccessState) {
                  final favorites = state.favorites;

                  if (favorites.isEmpty) {
                    return const Center(child: Text("No Favorites Found"));
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
                                        Container(
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
                                              imageUrl: product.product.image,
                                              height: 120.h,
                                              width: 100.w,
                                              fit: BoxFit.fitHeight,
                                              errorWidget: (context, url, error) =>
                                              const Icon(Icons.broken_image, size: 50, color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                                                ? const CircularProgressIndicator() // ⏳ أثناء الحذف
                                                                : const Icon(Icons.delete, color: Colors.red), // 🗑️ زر الحذف العادي
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
                                                  "${product.product.price} جنيه",
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.defaultcolor,
                                                  ),
                                                ),
                                                const SizedBox(height: 0),
                                                if (product.product.discount > 0)
                                                  Text(
                                                    " % خصم: ${product.product.discount}",
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
    );
  }
}
