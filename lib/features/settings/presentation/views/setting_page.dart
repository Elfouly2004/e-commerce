import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/shared_widgets/custom_appbar.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:mrcandy/features/settings/presentation/controller/setting_cubit.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_listview_Accountsetting.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_listview_appsetting.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/custom_setting_text.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/share_listile.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/setting_item_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..loadSettings(context), // تحميل البيانات عند الإنشاء
      child: Scaffold(
        body: Column(
          children: [

            SizedBox(
              height: 111.h,
              child: const CustomAppbar(title: AppTexts.Setting),
            ),


            CustomSettingText( data: AppTexts.Account_setting,),



            CustomListviewAccountsetting(),


            CustomSettingText( data: AppTexts.App_setting,),


            CustomListviewAppsetting()

          ],
        ),
      ),
    );
  }
}
