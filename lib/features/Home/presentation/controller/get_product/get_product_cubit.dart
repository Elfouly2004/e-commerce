import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/carts/data/model/cart_model.dart';
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
    if (productList.isNotEmpty) {
      emit(ProductsSuccessState());
      return;
    }

    emit(ProductsLoadingState());

    final result = await homeRepo.get_product();
    result.fold(
          (failure) {
        print("Error fetching products: ${failure.message}");
        emit(ProductsFailureState(errorMessage: failure.message));
      },
          (right) {
        productList = right;

        // تحديث المنتجات المحفوظة في Hive
        for (var product in productList) {
          final savedFavorite = favoritesBox.get(product.id.toString());
          if (savedFavorite != null) {
            product.inFavorites = savedFavorite; // استعادة حالة المنتج
          }
        }

        print("Fetched products: $productList");
        emit(ProductsSuccessState());
      },
    );
  }



  Future<void> addFavorite(context, int index) async {
    final result = await homeRepo.Addfav(context: context, index: index);

    result.fold(
          (failure) {
        print("Error adding to favorites: ${failure.message}");

        emit(ProductsFailureState(errorMessage: failure.message));

           },
          (updatedProduct) {


              productList[index].inFavorites = !productList[index].inFavorites;

              emit(updateFavoriteicon());

        favoritesBox.put(productList[index].id.toString(), productList[index].inFavorites);


              showDialog(
                context: context,
                builder: (context) {
                  return
                    FavoriteDialog(
                      onConfirm: () {
                        Navigator.of(context).pop();},
                      isAdded: productList[index].inFavorites,
                    );
                },
              );



        emit(ProductsSuccessState());
      },
    );
  }




  Future<void> addCart(context, int index) async {
    final result = await homeRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
            emit(ProductsFailureState(errorMessage: failure.message));
      },
          (updatedProduct) {

        cartsList[index] = updatedProduct;

        // إصدار حالة النجاح مع قائمة جديدة لضمان إعادة البناء
        emit(ProductsSuccessState());
      },
    );
  }



}
