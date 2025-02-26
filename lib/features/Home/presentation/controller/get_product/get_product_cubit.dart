import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/carts/data/model/cart_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/shared_widgets/custom_fav_dialog.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<ProductModel> productList = [];
  List<CartItemModel> cartsList = [];
  var favoritesBox = Hive.box('favorites-product');

  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchproducts() async {
    emit(ProductsLoadingState());

    final result = await homeRepo.get_product();
    result.fold(
          (failure) {
        if (failure is NoInternetFailure) {
          emit(NoInternetStates());
        } else {
          print("Error fetching products: ${failure.message}");
          emit(ProductsFailureState(errorMessage: failure.message));
        }
      },
          (products) {
        productList = products;

        for (var product in productList) {
          final savedFavorite = favoritesBox.get(product.id.toString());
          if (savedFavorite != null) {
            product.inFavorites = savedFavorite;
          }
        }

        print("Fetched products: $productList");
        emit(ProductsSuccessState());
      },
    );
  }

  Future<void> addFavorite(BuildContext context, int index) async {
    try {
      final result = await homeRepo.Addfav(context: context, index: index);

      result.fold(
            (failure) {
          print("Error adding to favorites: ${failure.message}");
          emit(ProductsFailureState(errorMessage: failure.message));
        },
            (updatedProduct) {
          productList[index].inFavorites = !productList[index].inFavorites;

          emit(updateFavoriteicon());

          try {
            favoritesBox.put(
                productList[index].id.toString(), productList[index].inFavorites);
          } catch (e) {
            print("Error saving favorite to Hive: $e");
          }

          showDialog(
            context: context,
            builder: (context) {
              return FavoriteDialog(isAdded: productList[index].inFavorites);
            },
          );

          emit(ProductsSuccessState());
        },
      );
    } catch (e) {
      print("Unexpected error in addFavorite: $e");
    }
  }

  Future<void> addCart(BuildContext context, int index) async {
    try {
      final result = await homeRepo.Add_carts(context: context, index: index);

      result.fold(
            (failure) {
          emit(ProductsFailureState(errorMessage: failure.message));
        },
            (updatedProduct) {
          if (index < cartsList.length) {
            cartsList[index] = updatedProduct;
          } else {
            cartsList.add(updatedProduct);
          }

          emit(ProductsSuccessState());
        },
      );
    } catch (e) {
      print("Unexpected error in addCart: $e");
    }
  }
}
