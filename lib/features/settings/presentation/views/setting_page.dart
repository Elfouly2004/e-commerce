import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/shared_widgets/custom_appbar.dart';
import 'package:mrcandy/features/settings/presentation/controller/cubit/setting/setting_cubit.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_listview_Accountsetting.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_listview_appsetting.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_setting_text.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('en', 'US'));

    return BlocProvider(
      create: (context) => SettingCubit()..loadSettings(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppbar(
            title: context.tr('Setting')
          ),
        ),
        body: Column(
          children: [


            CustomSettingText( data: "Account_setting".tr(),),



            CustomListviewAccountsetting(),


            CustomSettingText( data: "App_setting".tr(),),


            CustomListviewAppsetting()

          ],
        ),
      ),
    );
  }
}
