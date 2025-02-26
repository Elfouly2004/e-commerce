
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Category/presentation/controller/catgories%20sections%20%20cubit/catgories_sections%20_state.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import 'package:mrcandy/features/carts/data/model/cart_model.dart';

import '../../../../../core/shared_widgets/custom_fav_dialog.dart';
import '../../../data/repo/catgories_repo_implementation.dart';


import 'package:hive/hive.dart';

class CatgoriesSectionsCubit extends Cubit<CatgoriesSectionsState> {
  CatgoriesSectionsCubit() : super(CatgoriesSectionsInitial());

  final CatgoriesRepoImplementation CatgoriesRepo = CatgoriesRepoImplementation();
  List<ProductModel> categoriesdeatials_lst = [];
  List<CartItemModel> carts_categoriesdeatials_lst = [];

  final Box favoritesBox = Hive.box('favorites');

  static CatgoriesSectionsCubit get(context) => BlocProvider.of(context);

  Future<void> fetch_catgories_details({required int categoryId}) async {
    emit(CategoriesLoadingState());

    final result = await CatgoriesRepo.get_catgories_deatils(id: categoryId);

    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(CategoriesFailureState(errorMessage: failure.message));
    }, (data) {
      categoriesdeatials_lst = data;

      // استرجاع حالة المفضلة من التخزين
      for (var product in categoriesdeatials_lst) {
        product.inFavorites = favoritesBox.get(product.id.toString(), defaultValue: false);
      }

      print("Fetched banners: $categoriesdeatials_lst");
      emit(CategoriesSuccessState());
    });
  }

  Future<void> addFavorite(context, int index) async {
    final result = await CatgoriesRepo.Addfav(context: context, index: index);

    result.fold(
          (failure) {
        print("Error adding to favorites: ${failure.message}");
        emit(CategoriesFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {
        categoriesdeatials_lst[index].inFavorites = !categoriesdeatials_lst[index].inFavorites;

        emit(UpdateiconState());

        favoritesBox.put(
          categoriesdeatials_lst[index].id.toString(),
          categoriesdeatials_lst[index].inFavorites,
        );

        print("Updated favorite status: ${categoriesdeatials_lst[index].inFavorites}");

        emit(CategoriesSuccessState());



        showDialog(
          context: context,
          builder: (context) {
            return
              FavoriteDialog(

                isAdded: categoriesdeatials_lst[index].inFavorites,
              );
          },
        );
      },
    );
  }


  Future<void> addCart(context, int index) async {
    final result = await CatgoriesRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
        emit(CategoriesFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {

        carts_categoriesdeatials_lst[index] = updatedProduct;

        emit(CategoriesSuccessState());
      },
    );
  }








}



