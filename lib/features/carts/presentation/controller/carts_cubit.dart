import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/carts/data/repos/carts_repo_implmentation.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/cart_model.dart';
import 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitialState());

  final CartsRepoImplmentation cartRepo = CartsRepoImplmentation();
  List<CartItemModel> cartsList = [];
    int totalprice=0;
  static CartsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCarts() async {
    emit(CartsLoadingState());
    final result = await cartRepo.getCarts();

    result.fold(
          (failure) {

            if (failure is NoInternetFailure) {
              emit(cart_nointernetStates());
            }else{
              print("Error fetching carts: ${failure.message}");
              emit(CartsFailureState(failure.message));
            }

      },
          (data) {
        cartsList = data;
        totalprice = cartRepo.totalprice;

        emit(CartsSuccessState( cartsList, ));
      },
    );
  }



  Future<void> deleteCart(context, int index) async {

    final result = await cartRepo.DeleteCarts(context: context, index: index);

    result.fold(
          (failure) {
        emit(CartsFailureState(failure.message));
      },
          (_) {
           emit(CartsLoadingState()) ;

        cartsList.removeAt(index);

        emit(CartsSuccessState(cartsList,));


        print("deleeeeeeeeted");
      },
    );
  }


  Future<void> updateCartQuantity(int cartId, int newQuantity) async {
    print("Updating Cart - ID: $cartId, New Quantity: $newQuantity");

    final result = await cartRepo.updateCarts(IDcart: cartId, quantity: newQuantity);

    result.fold(
          (failure) {
        print("Update Failed: ${failure.message}");
        emit(CartsFailureState(failure.message));
      },
          (updatedCarts) {
        print("Cart Updated Successfully!");

        cartsList = updatedCarts;
        totalprice = updatedCarts.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

        emit(CartsSuccessState(cartsList));
      },
    );
  }







  Future<void> confirmCartUpdates() async {
    for (var item in cartsList) {
      await cartRepo.updateCarts(IDcart: item.id, quantity: item.quantity);
    }
    await fetchCarts();
  }





}
