import 'dart:io';
// لإضافة مكتبة dart:convert لتحويل الصورة إلى Base64
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mrcandy/features/login/presentation/view/Login.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../shared_widgets/Button_share.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
import '../../../../shared_widgets/custom_appbar.dart';
import '../../../../shared_widgets/rich_text.dart';
import '../controller/greate_account_cubit.dart';

class Greate_acoount extends StatelessWidget {
  const Greate_acoount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<GreateAccountCubit,GreateAccountState>(
        listener: (context, state) {
          if (state is GreateAccountSuccessState) {
            debugPrint("Account created successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          }
             else if (state is GreateAccountFailureState) {
            // Show failure alert
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
        builder:(context, state) {
          return  ModalProgressHUD(
            inAsyncCall: state is GreateAccountLoadingState,
            progressIndicator: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.Appbar1),
            ),
            child: Custom_Appbar(
              topRight: const Radius.circular(40.0) ,
              topLeft:  const Radius.circular(40.0),
              height: MediaQuery.of(context).size.height * 0.8,
              widget: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [


                    BlocBuilder<GreateAccountCubit, GreateAccountState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.Textformfeild, width: 2),
                              ),
                              child: BlocProvider.of<GreateAccountCubit>(context).myPhoto == null
                                  ? IconButton(
                                onPressed: () {
                                  BlocProvider.of<GreateAccountCubit>(context).choosephoto();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: AppColors.Textformfeild,
                                ),
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image.file(
                                  File(BlocProvider.of<GreateAccountCubit>(context).myPhoto!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "Add_profile_picture".tr(),
                              style: GoogleFonts.almarai(
                                color: AppColors.defaultcolor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    CustomTextformfeild(
                      keyboardType: TextInputType.name,
                      controller: BlocProvider.of<GreateAccountCubit>(context).Name,
                      suffixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.person,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText: "Enter_your_name".tr(),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    CustomTextformfeild(
                      keyboardType: TextInputType.emailAddress,
                      controller: BlocProvider.of<GreateAccountCubit>(context).Email,
                      suffixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.email_outlined,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText:"Enter_your_email".tr(),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    CustomTextformfeild(
                      keyboardType: TextInputType.phone,
                      controller: BlocProvider.of<GreateAccountCubit>(context).Phone,
                      suffixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              CupertinoIcons.phone,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText: "Enter_your_phone".tr(),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    CustomTextformfeild(
                      keyboardType: TextInputType.emailAddress,
                      controller: BlocProvider.of<GreateAccountCubit>(context).password,
                      suffixIcon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.lock_outlined,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText: "Enter_your_password".tr(),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    ButtonShare(
                      data: "Greate_account".tr(),
                      onTap: ()async {
                     BlocProvider.of<GreateAccountCubit>(context).Greateacoount(context);
                        },
                    ),

                    Rich_Text(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );

                      },
                      text1: "yes_account".tr(),
                      text2: "login".tr(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }  ,
      ),
    );
  }
}
