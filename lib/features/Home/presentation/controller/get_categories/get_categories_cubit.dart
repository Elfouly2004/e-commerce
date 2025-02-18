import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/data/model/categories_model.dart';
import '../../../data/repo/home_repo_implemetation.dart';
import 'get_categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitialState());

  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<CategoriesModel> categories_lst = [];


  static CategoriesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCategories() async {
    emit(CategoriesLoadingState());

    final result = await homeRepo.get_categories();
    result.fold((failure) {
      print("Error fetching categories: ${failure.message}");
      emit(CategoriesFailureState(errorMessage: failure.message));
    }, (data) {
      if (data.isNotEmpty) {
        categories_lst = data;
        print("Fetched categories: $categories_lst");
        emit(CategoriesSuccessState());
      } else {
        emit(CategoriesFailureState(errorMessage: "No categories found"));
      }
    });
  }

}
