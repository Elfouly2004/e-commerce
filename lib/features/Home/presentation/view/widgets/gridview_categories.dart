import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Category/presentation/view/category_screen.dart';
import '../../controller/get_categories/get_categories_cubit.dart';
import '../../controller/get_categories/get_categories_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesFailureState) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is CategoriesSuccessState) {
          final categories = context.read<CategoriesCubit>().categories_lst;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.6,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                        title: category.name,
                        id: category.id,
                      ),
                    ),
                  );
                },
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: category.urlImage,
                            fit: BoxFit.fitWidth,
                            // placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // مؤشر تحميل الصورة
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50, color: Colors.grey), // فشل تحميل الصورة
                          ),
                        ),
                      ),

                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
