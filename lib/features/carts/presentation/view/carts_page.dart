import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/shared_widgets/custom_lottie.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/carts_cubit.dart';
import '../controller/carts_state.dart';
import 'lstview.dart';
import 'package:lottie/lottie.dart';

class CartsPage extends StatefulWidget {
  const CartsPage({super.key});

  @override
  State<CartsPage> createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartsCubit>().fetchCarts();
  }

  Future<void> refresh() async {
    await context.read<CartsCubit>().fetchCarts();
  }
  @override

  int quantity = 1;


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppbar(
          title: 'bag'.tr(),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: BlocBuilder<CartsCubit, CartsState>(
                builder: (context, state) {
                  if (state is CartsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is cart_nointernetStates) {
                    return NoInternetWidget(
                      onRetry: () {
                        context.read<CartsCubit>().fetchCarts();
                      },
                    );
                  } else if (state is CartsFailureState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is CartsSuccessState) {
                    final cartItems = state.cartsList;
                    if (cartItems.isEmpty) {

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
                              "سلة المشتريات فارغة!",
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
                    return Lstview(
                      itemCount: cartItems.length,
                      cartitems: cartItems,
                    );
                  }
                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: context.locale.languageCode == 'ar'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child:Text(
                      "${"total".tr()} :${context.watch<CartsCubit>().totalprice}${"eg".tr()}",
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Appbar3,
                      ),
                    ),


                  ),
                ),

                SizedBox(height: 10.h),


                ElevatedButton(
                  onPressed: () async {
                    for (var item in context.read<CartsCubit>().cartsList) {
                      await BlocProvider.of<CartsCubit>(context).updateCartQuantity(item.id, item.quantity);
                    }

                    await context.read<CartsCubit>().confirmCartUpdates();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Appbar3,
                  ),
                  child: Text(
                    "confirm".tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          ),




        ],
      ),
    );
  }

}
