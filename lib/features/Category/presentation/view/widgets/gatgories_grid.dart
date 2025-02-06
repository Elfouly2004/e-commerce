import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/Category/presentation/controller/catgories%20sections%20%20cubit/catgories_sections%20_cubit.dart';
import 'package:mrcandy/features/Category/presentation/controller/catgories%20sections%20%20cubit/catgories_sections%20_state.dart';
import 'package:mrcandy/features/Category/presentation/view/category_details_screen.dart';
import '../../../../../core/utils/app_colors.dart';

class GatgoriesGrid extends StatefulWidget {
  final int categoryId;

  const GatgoriesGrid({super.key, required this.categoryId,});

  @override
  State<GatgoriesGrid> createState() => _GatgoriesGridState();
}

class _GatgoriesGridState extends State<GatgoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatgoriesSectionsCubit()..fetch_catgories_details(categoryId: widget.categoryId),
      child: GatgoriesGridContent(categoryId: widget.categoryId),
    );
  }
}

class GatgoriesGridContent extends StatelessWidget {
  final int categoryId;

  const GatgoriesGridContent({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatgoriesSectionsCubit, CatgoriesSectionsState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesSuccessState) {
          final products = context.read<CatgoriesSectionsCubit>().categoriesdeatials_lst;
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryDetailsScreen(product: product,),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 156.h,
                                  width: 180.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.gridproduct,
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      product.image,
                                      height: 100.h,
                                      width: 100.w,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 160.h,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<CatgoriesSectionsCubit>().addCart(context, index);
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
                                    Column(
                                      children: [
                                        Text(
                                          product.name.split(" ").join("\n"),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "  ${product.price}  جنيه",
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
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery.sizeOf(context).width * 0.09,
                                        height: MediaQuery.sizeOf(context).height * 0.022,
                                        decoration: BoxDecoration(
                                          color: AppColors.title,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          "-${product.discount}%",
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<CatgoriesSectionsCubit>().addFavorite(context, index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          child: Icon(
                                            product.inFavorites ? Icons.favorite : Icons.favorite_border,
                                            color: AppColors.defaultcolor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
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
