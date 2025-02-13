
import 'package:equatable/equatable.dart';
import 'package:mrcandy/features/favorite/data/model/fav_model.dart';

import '../../../Home/data/model/product_model.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesSuccessState extends FavoritesState {
  final List<FavItemModel> favorites;
  FavoritesSuccessState(this.favorites);
}

class FavoritesFailureState extends FavoritesState {
  final String errorMessage;
  FavoritesFailureState(this.errorMessage);
}

class NoInternetState extends FavoritesState {}
