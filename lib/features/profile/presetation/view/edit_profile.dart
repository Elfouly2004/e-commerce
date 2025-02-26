import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/shared_widgets/custom_button.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/profile_avatar.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/txt_form_field.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../settings/data/repo/setting_repo_implemntation.dart';
import '../../data/model/profile_model.dart';
import '../controller/profile_cubit/profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileModel profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(settingRepo: SettingRepoImplemntation()),
      child: EditProfilePageBody(profile: profile),
    );
  }
}

class EditProfilePageBody extends StatefulWidget {
  final ProfileModel profile;

  const EditProfilePageBody({super.key, required this.profile});

  @override
  _EditProfilePageBodyState createState() => _EditProfilePageBodyState();
}

class _EditProfilePageBodyState extends State<EditProfilePageBody> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String? uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phone);
    uploadedImageUrl = widget.profile.image;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    uploadedImageUrl?.toString();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          IconSnackBar.show(
            context,
            snackBarType: SnackBarType.alert,
            label: state.message.tr(),
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Colors.green,
            iconColor: Colors.white,
            maxLines: 2,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );  } else if (state is EditProfileFailure) {
          IconSnackBar.show(
            context,
            snackBarType: SnackBarType.alert,
            label: state.error,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Colors.red,
            iconColor: Colors.white,
            maxLines: 2,
          );
        } else if (state is EditProfileImageUploaded) {
       setState(() {
         uploadedImageUrl = state.imageUrl;
            });
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppbar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 25.sp),
            ),
            title: "Editprofile".tr(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProfileCubit>().choosephoto();
                },
                child: ProfileAvatar(
                  backgroundImage: uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty
                      ? (uploadedImageUrl!.startsWith("http") ? NetworkImage(uploadedImageUrl!)
                      : FileImage(File(uploadedImageUrl!)) as ImageProvider)
                      : AssetImage(""),
                ),
              ),
              SizedBox(height: 20),


              CustomTextFormField(
                controller: nameController,
                hintText: "Name",
                keyboardType: TextInputType.text,
                suffixIcon: null,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                suffixIcon: null,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: phoneController,
                hintText: "Phone",
                keyboardType: TextInputType.phone,
                suffixIcon: null,
              ),
              Spacer(),
              
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return CustomButton(
                    onTap: state is EditProfileLoading
                        ? null
                        : () {
                      context.read<ProfileCubit>().editProfile(
                        name: nameController.text,
                        email: emailController.text,
                        password: "",
                        phone: phoneController.text,
                        image: uploadedImageUrl ?? "",
                      );
                    },
                    text: state is EditProfileLoading ? "save".tr():"savechange".tr(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

