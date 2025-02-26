import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/carts/presentation/view/carts_page.dart';
import 'package:mrcandy/features/favorite/presentation/view/fav_page.dart';
import 'package:mrcandy/features/settings/presentation/views/setting_page.dart';
import 'home_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const FavoritesPage(),
    const CartsPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    String languageCode = context.locale.languageCode;

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SalomonBottomBar(
          backgroundColor: AppColors.bottomNavbar,
          unselectedItemColor: AppColors.white,
          currentIndex: currentIndex,
          onTap: (bottomIndex) {
            setState(() {
              currentIndex = bottomIndex;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.house_fill, size: 25.sp),
              title: Text(languageCode == "ar" ? "الرئيسية" : "Home"),
              selectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.heart, size: 25.sp),
              title: Text(languageCode == "ar" ? "المفضلة" : "Favorites"),
              selectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.bag, size: 25.sp),
              title: Text(languageCode == "ar" ? "السلة" : "Cart"),
              selectedColor: AppColors.white,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.settings, size: 25.sp),
              title: Text(languageCode == "ar" ? "الإعدادات" : "Settings"),
              selectedColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
