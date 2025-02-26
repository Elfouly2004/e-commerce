import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/Home/presentation/controller/get_product/get_product_state.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/shared_widgets/custom_fav_dialog.dart';
import '../../../../carts/data/model/cart_model.dart';
import '../../../data/model/banners_model.dart';
import '../../../data/model/categories_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<BannersModel> banners = [];
  List<CategoriesModel> categories = [];
  List<ProductModel> products = [];
  List<CartItemModel> cartsList = [];

  var favoritesBox = Hive.box('favorites-product');

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> fetchBanners() async {
    emit(LoadingState());

    final result = await homeRepo.get_banners();
    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(FailureState(errorMessage: failure.message));
    }, (data) {
      if (data.isNotEmpty) {
        banners = data;
        print("Fetched banners: $banners");  // Debug output
        emit(SuccessState());
      } else {
        emit(FailureState(errorMessage: "No banners found"));
      }
    });
  }

  Future<void> fetchCategories(context) async {
    emit(LoadingState());

    final result = await homeRepo.get_categories(context);
    result.fold((failure) {
      print("Error fetching categories: ${failure.message}");
      emit(FailureState(errorMessage: failure.message));
    }, (data) {
      if (data.isNotEmpty) {
        categories = data;
        print("Fetched categories: $categories");
        emit(SuccessState());
      } else {
        emit(FailureState(errorMessage: "No categories found"));
      }
    });
  }


  Future<void> fetchproducts() async {
    if (products.isNotEmpty) {
      emit(SuccessState());
      return;
    }

    emit(LoadingState());

    final result = await homeRepo.get_product();
    result.fold(
          (failure) {

        if (failure is NoInternetFailure) {
          emit(NoInternetStates() as HomeState);
        }else{
          print("Error fetching products: ${failure.message}");
          emit(FailureState(errorMessage: failure.message));

        }

      },
          (right) {
            products = right;

        for (var product in products) {
          final savedFavorite = favoritesBox.get(product.id.toString());
          if (savedFavorite != null) {
            product.inFavorites = savedFavorite;
          }
        }

        print("Fetched products: $products");
        emit(SuccessState());
      },
    );
  }



  Future<void> addFavorite(context, int index) async {
    final result = await homeRepo.Addfav(context: context, index: index);

    result.fold(
          (failure) {
        print("Error adding to favorites: ${failure.message}");

        emit(FailureState(errorMessage: failure.message));

      },
          (updatedProduct) {


            products[index].inFavorites = !products[index].inFavorites;

        emit(updatefavoriteicon());

        favoritesBox.put(products[index].id.toString(), products[index].inFavorites);


        showDialog(
          context: context,
          builder: (context) {
            return
              FavoriteDialog(

                isAdded: products[index].inFavorites,
              );
          },
        );



        emit(SuccessState());
      },
    );
  }




  Future<void> addCart(context, int index) async {
    final result = await homeRepo.Add_carts(context: context, index: index);

    result.fold(
          (failure) {
        emit(FailureState(errorMessage: failure.message));
      },
          (updatedProduct) {

        cartsList[index] = updatedProduct;

        emit(SuccessState());
      },
    );
  }

}

