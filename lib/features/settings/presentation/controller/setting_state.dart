part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final List<SettingItemModel> accountSettings;
  final List<SettingItemModel> appSettings;

  SettingLoaded(this.accountSettings, this.appSettings);
}
