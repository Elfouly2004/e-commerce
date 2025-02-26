import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../profile/presetation/view/widgets/txt_field.dart';
import '../controller/change_pass_cubit.dart';
import '../controller/change_pass_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppbar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 25.sp),
          ),
          title: "changepassword".tr(),
        ),
      ),
      body: BlocConsumer<ChangePassCubit, ChangePassState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.bottom_g1),
            );
            _currentPasswordController.clear();
            _newPasswordController.clear();
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text("CurrentPassword".tr()),
                CustomTextField(
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrentPassword,
                  hintText: "Enteroldpassword".tr(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureCurrentPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Text("newpassword".tr()),
                CustomTextField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  hintText: "Enternewpassword".tr(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNewPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                Spacer(),

                Expanded(
                  child: Center(
                    child: CustomButton(
                      text: "changepassword".tr(),
                      onTap: state is ChangePasswordLoading ? null : () {
                        context.read<ChangePassCubit>().changepass(
                          currentPassword: _currentPasswordController.text,
                          newPassword: _newPasswordController.text,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}

