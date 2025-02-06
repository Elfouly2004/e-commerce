import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/app_texts.dart';
import '../../data/model/setting_item_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());


  void loadSettings() {
    final List<SettingItemModel> accountSettings = [
      SettingItemModel(
        title: AppTexts.profile,
        leadingIcon: CupertinoIcons.profile_circled,
        onTap: () {},
      ),
      SettingItemModel(
        title: "Change Password",
        leadingIcon: Icons.lock_outline,
        onTap: () {},
      ),
      SettingItemModel(
        title: "Privacy Settings",
        leadingIcon: Icons.privacy_tip_outlined,
        onTap: () {},
      ),
    ];

    final List<SettingItemModel> appSettings = [
      SettingItemModel(
        title: AppTexts.notifications,
        leadingIcon: Icons.notifications,
        onTap: () {},
      ),
      SettingItemModel(
        title: AppTexts.language,
        leadingIcon: Icons.language,
        onTap: () {},
      ),
      SettingItemModel(
        title: AppTexts.themes,
        leadingIcon: Icons.color_lens,
        onTap: () {},
      ),
    ];


    emit(SettingLoaded(accountSettings, appSettings));
  }
}
