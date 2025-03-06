import 'package:equatable/equatable.dart';

import '../../data/model/cart_model.dart';

abstract class CartsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CartsInitialState extends CartsState {}

class CartsLoadingState extends CartsState {}

class CartsSuccessState extends CartsState {
  final List<CartItemModel> cartsList;
  CartsSuccessState(this.cartsList);
}
class CartsFailureState extends CartsState {
  final String errorMessage;
  CartsFailureState(this.errorMessage);
}

class cart_nointernetStates extends CartsState {}
class cart_updateStates extends CartsState {}
