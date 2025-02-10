import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/fav_model.dart';
import '../../data/repo/fav_repo_implemntation.dart';
import 'fav_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitialState());

  final FavRepoImplemntation FavRepo = FavRepoImplemntation();
  List<FavItemModel> favoritesList = [];
  int? loadingIndex; // 🟡 لتحديد العنصر الجاري حذفه

  static FavoritesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchFavorites() async {
    emit(FavoritesLoadingState());
    final result = await FavRepo.getfav();

    result.fold(
          (failure) {
        print("Error fetching favorites: ${failure.message}");
        emit(FavoritesFailureState(failure.message));
      },
          (data) {
        favoritesList = List.from(data);
        emit(FavoritesSuccessState(List.from(favoritesList)));
      },
    );
  }

  Future<void> deletefav(BuildContext context, int index) async {
    loadingIndex = index;
    emit(FavoritesSuccessState(List.from(favoritesList)));

    final result = await FavRepo.DeleteFav(context: context, index: index);

    result.fold(
          (failure) {
        debugPrint(" Error Deleting Favorite: ${failure.message}");
        loadingIndex = null;
        emit(FavoritesSuccessState(List.from(favoritesList)));
      },
          (_) {
        debugPrint("🟢 Favorite Deleted Successfully: Index $index");

        // التأكد من أن `index` لا يتجاوز حجم القائمة
        if (index >= 0 && index < favoritesList.length) {
          favoritesList.removeAt(index);
        }
        loadingIndex = null;

        // إعادة تحميل القائمة بعد الحذف
        fetchFavorites();
      },
    );
  }


}

