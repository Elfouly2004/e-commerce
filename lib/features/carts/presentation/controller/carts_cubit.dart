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
        totalprice = cartRepo.totalprice; // تحديث قيمة totalprice

        emit(CartsSuccessState(cartsList));
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

        // حذف العنصر من القائمة
        cartsList.removeAt(index);

        emit(CartsSuccessState(List.from(cartsList)));


        print("deleeeeeeeeted");
      },
    );
  }


}
