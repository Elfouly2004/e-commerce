

import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_texts.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String buttonText;



  OnboardingModel(
      {required this.title,
        required this.image,
        required this.buttonText,
      }
      );
}

List<OnboardingModel>  sliders = [

  OnboardingModel(
      title: "Slider1_Title".tr(),
      image: AppImages.slider1,
      buttonText:"Slider_Button1".tr(),
  ) ,


  OnboardingModel(
      title:"Slider2_Title".tr(),
      image: AppImages.slider2,
      buttonText:"Slider_Button1".tr(),
  ) ,

  OnboardingModel(
      title: "Slider3_Title".tr(),
      image: AppImages.slider3,
      buttonText: "Slider_Button2".tr(),
  ),
];
