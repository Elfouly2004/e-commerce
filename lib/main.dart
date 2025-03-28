import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/core/utils/api_keys.dart';
import 'package:mrcandy/features/Greate_account/data/repo/Greate_account_impelemntation.dart';
import 'package:mrcandy/features/login/data/repo/login_repo_impelemntation.dart';
import 'package:mrcandy/features/settings/data/repo/setting_repo_implemntation.dart';
import 'cubit_mrcandy.dart';
import 'features/Greate_account/presentation/controller/greate_account_cubit.dart';
import 'features/Home/presentation/controller/get_banners/get_banners_cubit.dart';
import 'features/Home/presentation/controller/get_categories/get_categories_cubit.dart';
import 'features/Home/presentation/controller/get_product/get_product_cubit.dart';
import 'features/carts/presentation/controller/carts_cubit.dart';
import 'features/change_pass/presentation/controller/change_pass_cubit.dart';
import 'features/login/presentation/controller/login_cubit.dart';
import 'features/payment/presentation/view/payment_scren.dart';
import 'features/payment/presentation/view/thankyou_screen.dart';
import 'features/splash_screen/views/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  Stripe.publishableKey=ApiKeys.publishkey;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("setting");
  await Hive.openBox('favorites');
  await Hive.openBox('favorites-product');
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        path: 'assets/translation',
        fallbackLocale: const Locale('ar'),
        startLocale: Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode),

        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsCubit()..fetchproducts()),
        BlocProvider(create: (_) => BannersCubit()..fetchBanners()),
        BlocProvider(create: (_) => CategoriesCubit()..fetchCategories(context)),
        BlocProvider(create: (_) => CartsCubit()..fetchCarts()),
        BlocProvider(create: (_) => ChangePassCubit(settingRepo: SettingRepoImplemntation())),
        BlocProvider(create: (_) => LoginCubit(LoginRepoImplementation())),
        BlocProvider(create: (_) => GreateAccountCubit(GreateAccountImplementation())),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          debugShowCheckedModeBanner: false,
          title: 'Mr Candy',
          home: splashscreen(),
          // home: PaymentScren(),
          // home: ThankyouScreen(),
        );
      },


    );
  }
}



