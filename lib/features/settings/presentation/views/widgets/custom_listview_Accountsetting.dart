import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/utils/extensions/trans.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/share_listile.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../controller/cubit/setting/setting_cubit.dart';


class CustomListviewAccountsetting extends StatelessWidget {
  const CustomListviewAccountsetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is SettingInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingLoaded) {
          final settings = state.accountSettings;
          return Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: settings.length,
              itemBuilder: (context, index) {
                final item = settings[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ShareListile(
                    title: Text(
                      item.title.tr(),
                      style: GoogleFonts.almarai(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Appbar2,
                      ),
                    ),
                    leading: Icon(
                      item.leadingIcon,
                      size: 25.sp,
                      color: AppColors.Appbar3,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.Appbar3,
                    ),
                    onTap: item.onTap,
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text("Something went wrong!"));
        }
      },
    );
  }
}

