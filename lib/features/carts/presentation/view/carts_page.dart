import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/carts/presentation/view/widgets/cutom_done.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_lottie.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/carts_cubit.dart';
import '../controller/carts_state.dart';
import 'widgets/lstview.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CartsPage extends StatefulWidget {
  const CartsPage({super.key});

  @override
  State<CartsPage> createState() => _CartsPageState();
}


class _CartsPageState extends State<CartsPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    setState(() => isLoading = true);
    await context.read<CartsCubit>().fetchCarts();
    setState(() => isLoading = false);
  }

  // Future<void> refresh() async {
  //   await fetchCartData();
  // }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppbar(
          title: 'bag'.tr(),
        ),
      ),
      body: BlocBuilder<CartsCubit, CartsState>(
        builder: (context, state) {
          if (state is CartsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is cart_nointernetStates) {
            return NoInternetWidget(
              onRetry: fetchCartData,
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

            return Column(
              children: [
                Expanded(
                  child:

                  Lstview(
                    itemCount: cartItems.length,
                    cartitems: cartItems,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    children: [
                      CutomDone(),

                      SizedBox(height: 10.h),


                      CustomButton(
                        onTap: () async {
                          setState(() => isLoading = true);
                          for (var item in context.read<CartsCubit>().cartsList) {
                            await BlocProvider.of<CartsCubit>(context)
                                .updateCartQuantity(item.id, item.quantity);
                          }
                          await context.read<CartsCubit>().confirmCartUpdates();
                          setState(() => isLoading = false);
                        },
                        text: "confirm".tr(),
                      ),


                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

}

