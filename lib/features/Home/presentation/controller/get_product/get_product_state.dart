import 'package:equatable/equatable.dart';


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

class ProductsSuccessState extends ProductsState {}

class updateFavoriteicon extends ProductsState {}


class NoInternetStates extends ProductsState {}
