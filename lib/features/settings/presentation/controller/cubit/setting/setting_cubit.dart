import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../change_pass/presentation/view/changepass_screen.dart';
import '../../../../../profile/presetation/view/profile_page.dart';
import '../../../../data/model/setting_item_model.dart';
import '../../../views/screens/language/language.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());


  void loadSettings(BuildContext context) {

    final List<SettingItemModel> accountSettings = [
      SettingItemModel(
        title: 'profile',
        leadingIcon: CupertinoIcons.profile_circled,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
        },
      ),
      SettingItemModel(
        title: 'ChangePassword',
        leadingIcon: Icons.lock_outline,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(),));

        },
      ),
      SettingItemModel(
        title: 'PrivacySettings',
        leadingIcon: Icons.privacy_tip_outlined,
        onTap: () {
        },
      ),
    ];

    final List<SettingItemModel> appSettings = [
      SettingItemModel(
        title: 'notifications',
        leadingIcon: Icons.notifications,
        onTap: () {},
      ),
      SettingItemModel(
        title: 'language',
        leadingIcon: Icons.language,
        onTap: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage(),));


        },
      ),
      SettingItemModel(
        title: 'themes',
        leadingIcon: Icons.color_lens,
        onTap: () {},
      ),
    ];


    emit(SettingLoaded(accountSettings, appSettings));
  }


}
