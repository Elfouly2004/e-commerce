import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/Category/presentation/view/widgets/cystom_txt.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import '../../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import 'dart:ui' as ui;


class CategoryDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const CategoryDetailsScreen({super.key, required this.product});

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  int selectedImageIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar' ?ui. TextDirection.rtl :ui. TextDirection.ltr,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppbar(
            title: "Productdetails".tr(),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.white,
                size: 30.r,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.white,

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // مناسب للـ LTR و RTL تلقائيًا
            children: [
              const SizedBox(height: 20),

              Center(
                child: Container(
                  height: 200.h,
                  width: 300.w,
                  decoration: BoxDecoration(),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: widget.product.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        selectedImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: widget.product.images[index],
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 80.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImageIndex = index;
                          pageController.jumpToPage(index);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          width: 90.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: selectedImageIndex == index ? AppColors.Appbar3 : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.images[index],
                            fit: BoxFit.fitHeight,
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),

              // اسم المنتج
              CystomTxt(
                data: widget.product.name,
                fontSize: 18,
                color: Colors.black,
              ),

              const SizedBox(height: 20),

              CystomTxt(
                data: "${"price".tr()} : ${widget.product.price}  ${"eg".tr()}",
                fontSize: 18,
                color: Colors.green,
              ),

              const SizedBox(height: 10),

              CystomTxt(
                data: "${"offer".tr()} : ${widget.product.discount} %",
                fontSize: 15,
                color: Colors.red,
              ),

              const SizedBox(height: 10),

              CystomTxt(
                data: widget.product.description.split(".")[0],
                fontSize: 18,
                color: Colors.black,
              ),

              const Spacer(),

              Center(
                child: CustomButton(
                  onTap: () {},
                  text: "Addtocart".tr(),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

}