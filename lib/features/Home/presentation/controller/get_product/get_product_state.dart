import 'package:equatable/equatable.dart';

import '../../../data/model/product_model.dart';

abstract class ProductsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsFailureState extends ProductsState {
  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}

class ProductsSuccessState extends ProductsState {
  final List<ProductModel> productList;

  // اضف هنا ميزة Equatable لمقارنة الحقول المهمة فقط
  ProductsSuccessState(this.productList);

  @override
  List<Object?> get props => [productList];
}

class AddFavoriteSuccessState extends ProductsState {
  final ProductModel product;

  AddFavoriteSuccessState(this.product);
}
