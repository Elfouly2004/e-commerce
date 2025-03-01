import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../data/model/fav_model.dart';
import '../../data/repo/fav_repo_implemntation.dart';
import 'fav_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitialState());

  final FavRepoImplemntation FavRepo = FavRepoImplemntation();
  List<FavItemModel> favoritesList = [];
  int? loadingIndex;

  static FavoritesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchFavorites() async {
    emit(FavoritesLoadingState());
    final result = await FavRepo.getfav();

    result.fold(
          (failure) {


            if (failure is NoInternetFailure) {
              emit(NoInternetState());
            }else{
              print("Error fetching favorites: ${failure.message}");
              emit(FavoritesFailureState(failure.message));
            }

      },
          (data) {
        favoritesList = List.from(data);
        emit(FavoritesSuccessState(List.from(favoritesList)));
      },
    );
  }

  Future<void> deletefav(BuildContext context, int index) async {

    final result = await FavRepo.DeleteFav(context: context, index: index);

    result.fold(
          (failure) {
       emit(FavoritesFailureState(failure.message));
      },
          (_) {


        debugPrint("Favorite Deleted Successfully: Index $index");


             emit(FavoritesLoadingState());

          favoritesList.removeAt(index);


        emit(FavoritesSuccessState(List.from(favoritesList)));


      },
    );
  }


}

