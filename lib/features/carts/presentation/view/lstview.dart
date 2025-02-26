import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../controller/carts_cubit.dart';
import 'Richtxt.dart';
import 'dart:ui' as ui;


class Lstview extends StatelessWidget {
  const Lstview({super.key, this.itemCount, this.cartitems});

  final int? itemCount;
  final dynamic cartitems;


  @override
  Widget build(BuildContext context) {
    bool isArabic = Directionality.of(context) ==ui.TextDirection.rtl;

    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (context, index) {
        final item = cartitems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 175.h,
            width: 330.w,
            decoration: BoxDecoration(
              color: AppColors.gridproduct,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Stack(
              children: [

                Positioned(
                  top: 0,
                  left: isArabic ? null : 0,
                  right: isArabic ? 0 : null,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<CartsCubit>(context).deleteCart(context, index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(isArabic ? 20.r : 0),
                          topLeft: Radius.circular(isArabic ? 0 : 20.r),
                          bottomLeft: Radius.circular(isArabic ? 25.r : 2.r),
                          bottomRight: Radius.circular(isArabic ? 2.r : 25.r),
                        ),
                      ),
                      child: Text(
                        "delete".tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.only(top: 15, start: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (!isArabic) _buildProductImage(item),

                      SizedBox(width: 15.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 10),


                            Text(
                              item.product.name,
                              textDirection: isArabic ? ui.TextDirection.rtl :ui. TextDirection.ltr,
                              style: GoogleFonts.almarai(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cartresult,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),


                            Row(
                              children: [
                                Richtxt(
                                  txt1: "Amount".tr(),
                                  txt2: "${item.quantity}",
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),

                            Row(
                              children: [
                                Richtxt(
                                  txt1:" ${"Total".tr()} : ",
                                  txt2: "${item.product.price * item.quantity} ${"eg".tr()}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      if (isArabic) _buildProductImage(item),
                    ],
                  ),
                ),

                Positioned(
                  top: 120.h,
                  left: isArabic ? null : 130,
                  right: isArabic ? 130 : null,
                  child: Row(
                    children: [
                      _buildQuantityButton(
                        icon: Icons.remove,
                        color: AppColors.bottom_g1,
                        onTap: () {
                        },
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        item.quantity.toString().padLeft(2, "0"),
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      _buildQuantityButton(
                        icon: Icons.add,
                        color: AppColors.Appbar3,
                        onTap: () {

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductImage(item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: CachedNetworkImage(
        imageUrl: item.product.image,
        height: 100.h,
        width: 80.w,
        fit: BoxFit.fitHeight,
        errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50, color: Colors.red),
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(5.w),
        child: Icon(
          icon,
          size: 20.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
