import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/profile_avatar.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/profile_list_tile.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo_implemntation.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../controller/profile_cubit.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(settingRepo: SettingRepoImplemntation())..fetchProfile(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppbar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 25.sp),
            ),
            title: "Profile",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileFailure) {
                return Center(
                  child: Text("Error: ${state.message}", style: TextStyle(color: Colors.red)),
                );
              } else if (state is ProfileSuccess) {
                final profile = state.profile;
                return Column(
                  children: [
                    SizedBox(height: 30),
                    ProfileAvatar(imageUrl: profile.image),
                    SizedBox(height: 30),
                    Text(
                      profile.name ?? "No Name",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),


                    ProfileInfoTile(icon: Icons.email, text: profile.email ?? "No Email", iconColor: Colors.blue),


                    SizedBox(height: 20),


                    ProfileInfoTile(icon: Icons.phone, text: profile.phone ?? "No Phone", iconColor: Colors.green),


                    SizedBox(height: 150),


                    CustomButton(
                      onTap: () {},
                      text: "Edit Profile",
                    ),

                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
