
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/banners_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_banners_state.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit() : super(BannersInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();


  List<BannersModel> banners = [];
  static BannersCubit get(context) => BlocProvider.of(context);
  Future<void> fetchBanners() async {
    emit(BannersLoadingState());

    final result = await homeRepo.get_banners();
    result.fold((failure) {
      print("Error fetching banners: ${failure.message}");
      emit(BannersFailureState(errorMessage: failure.message));
    }, (data) {
      if (data.isNotEmpty) {
        banners = data;
        print("Fetched banners: $banners");  // Debug output
        emit(BannersSuccessState());
      } else {
        emit(BannersFailureState(errorMessage: "No banners found"));
      }
    });
  }


}
