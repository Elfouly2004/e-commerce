import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/shared_widgets/custom_button.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/profile_avatar.dart';
import 'package:mrcandy/features/profile/presetation/view/widgets/txt_form_field.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
import '../../../settings/data/repo/setting_repo_implemntation.dart';
import '../../data/model/profile_model.dart';
import '../controller/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileModel profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(editProfileRepo: SettingRepoImplemntation()),
      child: EditProfilePageBody(profile: profile),
    );
  }
}

class EditProfilePageBody extends StatefulWidget {
  final ProfileModel profile;

  const EditProfilePageBody({Key? key, required this.profile}) : super(key: key);

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
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          IconSnackBar.show(
            context,
            snackBarType: SnackBarType.alert,
            label: state.message,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Colors.green,
            iconColor: Colors.white,
            maxLines: 2,
          );
          Navigator.pop(context);
        } else if (state is EditProfileFailure) {
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
            title: "Edit Profile",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<EditProfileCubit>().choosephoto();
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
              
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  return CustomButton(
                    onTap: state is EditProfileLoading
                        ? null
                        : () {
                      context.read<EditProfileCubit>().editProfile(
                        name: nameController.text,
                        email: emailController.text,
                        password: "",
                        phone: phoneController.text,
                        image: uploadedImageUrl ?? "",
                      );
                    },
                    text: state is EditProfileLoading ? "Saving..." : "Save Changes",
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

