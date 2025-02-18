import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../change_pass/presentation/view/changepass_screen.dart';
import '../../../profile/presetation/view/profile_page.dart';
import '../../data/model/setting_item_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());


  void loadSettings(context) {
    final List<SettingItemModel> accountSettings = [
      SettingItemModel(
        title: AppTexts.profile,
        leadingIcon: CupertinoIcons.profile_circled,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
        },
      ),
      SettingItemModel(
        title: "Change Password",
        leadingIcon: Icons.lock_outline,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(),));

        },
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
