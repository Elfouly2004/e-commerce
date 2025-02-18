import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../controller/get_product/get_product_cubit.dart';
import '../../controller/get_product/get_product_state.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  void initState() {
    super.initState();
    final cubit = ProductsCubit.get(context);
    if (cubit.productList.isEmpty) {
      cubit.fetchproducts();
    }
  }
  Widget build(BuildContext context) {



    double deviceHeight = MediaQuery.of(context).size.height;
    int contanierheight, contanierwidth ,imgheight ,
        imgwidth , container2 ,space, radius ,iconsize;

    if (deviceHeight > 1400) {

      contanierheight=350;
      contanierwidth=350;
      imgheight=300;
      imgwidth=270;
      container2=40;
      space=250;
      iconsize=30;
      radius=30;


    }
    else if (deviceHeight > 1340) {
      contanierheight=270;
      contanierwidth=270;
      imgheight=240;
      imgwidth=200;
      container2=40;
      space=200;
      iconsize=30;
      radius=30;


    }
    else  if (deviceHeight > 1000) {


      contanierheight=200;
      contanierwidth=200;
      imgheight=300;
      imgwidth=270;
      container2=40;
      space=120;
      iconsize=20;
      radius=20;

    }
    else if (deviceHeight > 850) {
      // الأجهزة الكبيرة
      contanierheight=150;
      contanierwidth=150;
      imgheight=130;
      imgwidth=140;
      container2=25;
      space=95;
      iconsize=15;
      radius=15;

    }
    else if (deviceHeight >= 800){
      // الأجهزة المتوسطة
      contanierheight=140;
      contanierwidth=140;
      imgheight=120;
      imgwidth=130;
      container2=30;
      space=75;
      iconsize=15;
      radius=15;



    }
    else if (deviceHeight > 750) {
      // الأجهزة المتوسطة
      contanierheight=160;
      contanierwidth=140;
      imgheight=160;
      imgwidth=200;
      container2=30;
      space=80;
      iconsize=15;
      radius=15;



    }
    else if (deviceHeight > 700) {
      // الأجهزة الصغيرة
      contanierheight=150;
      contanierwidth=130;
      imgheight=160;
      imgwidth=200;
      container2=25;
      space=85;
      iconsize=15;
      radius=20;



    }
    else {
      // الأجهزة الصغيرة جدًا
      contanierheight=130;
      contanierwidth=130;
      imgheight=120;
      imgwidth=120;
      container2=25;
      space=70;
      iconsize=15;
      radius=15;



    }



    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsFailureState) {
          print("Error: ${state.errorMessage}"); // Debug log
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is ProductsSuccessState) {
          final products = context.read<ProductsCubit>().productList;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Wrap(
              spacing: 20.0.w,
              runSpacing: 20.0.h,
              textDirection: TextDirection.rtl,
              children: List.generate(
                products.length,
                    (index) {
                  final product = products[index];
                  return Stack(
                    children: [
                      Container(
                        width: contanierwidth.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: contanierheight.h,
                              width: 400.w,
                              decoration: const BoxDecoration(
                                color: AppColors.gridproduct,
                              ),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  height: imgheight.h,
                                  width: imgwidth.w,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            Text(
                              product.name.split(" ").join(" "),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<ProductsCubit>(context)
                                        .addCart(context, index);
                                  },
                                  child: Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.defaultcolor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "  ${product.price}  جنيه",
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.defaultcolor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 5.h,
                        right: 5.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.w),
                              height: container2.h,
                              width: container2.w,
                              decoration: BoxDecoration(
                                color: AppColors.title,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "-${product.discount}%",
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: space.w),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<ProductsCubit>(context).addFavorite(context, index);
                                // BlocProvider.of<ProductsCubit>(context).updateicon(context, index);
                              },
                              child: CircleAvatar(
                                radius: radius.r,
                                backgroundColor: AppColors.white,
                                child: Icon(
                                  BlocProvider.of<ProductsCubit>(context)
                                      .productList[index]
                                      .inFavorites
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.defaultcolor,
                                  size: iconsize.sp,
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
            ),
          );

        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );

  }
}
