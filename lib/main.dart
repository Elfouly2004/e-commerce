import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
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
import 'features/favorite/presentation/controller/fav_cubit.dart';
import 'features/login/presentation/controller/login_cubit.dart';
import 'features/splash_screen/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("setting");
  await Hive.openBox('favorites');
  await Hive.openBox('favorites-product');
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsCubit()..fetchproducts()),

        BlocProvider(create: (_)=> BannersCubit()..fetchBanners()),

        BlocProvider( create: (_) => CategoriesCubit()..fetchCategories(),),

        BlocProvider(  create: (context) => FavoritesCubit()..fetchFavorites(),),

        BlocProvider(  create: (context) => CartsCubit()..fetchCarts(),),

        BlocProvider(  create: (context) => ChangePassCubit( settingRepo: SettingRepoImplemntation())),

        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginRepoImplementation()),
        ),

        BlocProvider<GreateAccountCubit>(
          create: (context) => GreateAccountCubit(GreateAccountImplementation()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mr Candy',
          home:  splashscreen(),
          builder: DevicePreview.appBuilder,
        );
      },
    );
  }
}