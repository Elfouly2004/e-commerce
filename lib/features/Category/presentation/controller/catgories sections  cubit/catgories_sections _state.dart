
import 'package:equatable/equatable.dart';

abstract class CatgoriesSectionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CatgoriesSectionsInitial extends CatgoriesSectionsState {}
class CategoriesLoadingState extends CatgoriesSectionsState { }
class CategoriesFailureState extends CatgoriesSectionsState {
  final String errorMessage ;
  CategoriesFailureState({required this.errorMessage}) ;
}
class CategoriesSuccessState extends CatgoriesSectionsState { }
class UpdateiconState extends CatgoriesSectionsState { }
class UpdateiconSuccessState extends CatgoriesSectionsState { }
