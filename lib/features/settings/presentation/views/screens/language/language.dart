import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/extensions/trans.dart';
import '../../../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../controller/cubit/setting/setting_cubit.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppbar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 25.sp),
          ),
          title: context.changeLanguage,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 25.h, left: 5.w, right: 5.w),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 5,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("🇬🇧 English", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Switch(
                  value: isEnglish,
                  onChanged: (value) {
                    Locale newLocale = value ? const Locale('ar') : const Locale('en');
                    context.setLocale(newLocale);
                    setState(() {});
                  },
                  activeColor: AppColors.Appbar3,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade300,
                ),
                Text("🇸🇦 العربية", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}