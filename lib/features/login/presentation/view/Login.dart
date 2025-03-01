import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../shared_widgets/Button_share.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
import '../../../../shared_widgets/custom_appbar.dart';
import '../../../../shared_widgets/rich_text.dart';
import '../../../Greate_account/presentation/view/greate acoount.dart';
import '../controller/login_cubit.dart';
import 'dart:ui' as ui;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            } else if (state is LoginFailureState) {
              IconSnackBar.show(
                context,
                snackBarType: SnackBarType.alert,
                label: state.errorMessage,
                labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                backgroundColor: AppColors.Appbar2,
                iconColor: Colors.white,
                maxLines: 2,
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LoginLoadingState,
              progressIndicator: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.Appbar1),
              ),
              child: Custom_Appbar(
                topLeft: isArabic ? const Radius.circular(0) : const Radius.circular(40.0),
                topRight: isArabic ? const Radius.circular(40.0) : const Radius.circular(0),
                height: MediaQuery.of(context).size.height * 0.8,
                widget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isArabic ? 20 : 25),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                      CustomTextformfeild(
                        keyboardType: TextInputType.emailAddress,
                        controller: BlocProvider.of<LoginCubit>(context).Email,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 30,
                              child: VerticalDivider(
                                color: AppColors.Textformfeild,
                                thickness: 1.5,
                                width: 10,
                                indent: 1,
                                endIndent: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: isArabic ? 15 : 0, right: isArabic ? 0 : 15),
                              child: const Icon(
                                Icons.email_outlined,
                                color: AppColors.Textformfeild,
                              ),
                            ),
                          ],
                        ),
                        hintText: "Enter_your_email".tr(),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                      CustomTextformfeild(

                        keyboardType: TextInputType.visiblePassword,
                        controller: BlocProvider.of<LoginCubit>(context).password,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 30,
                              child: VerticalDivider(
                                color: AppColors.Textformfeild,
                                thickness: 1.5,
                                width: 10,
                                indent: 1,
                                endIndent: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: isArabic ? 15 : 0, right: isArabic ? 0 : 15),
                              child: const Icon(
                                Icons.lock_outlined,
                                color: AppColors.Textformfeild,
                              ),
                            ),
                          ],
                        ),
                        hintText: "Enter_your_password".tr(),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                      ButtonShare(
                        data: "login".tr(),
                        onTap: () {
                          BlocProvider.of<LoginCubit>(context).login();
                        },
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      Rich_Text(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Greate_acoount()));
                        },
                        text1: "No_account".tr(),
                        text2: "signup_login".tr(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
