import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_module.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/ui/screen/favorite/favorite_module.dart';
import 'package:restaurant_app/ui/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/ui/screen/home/home_module.dart';
import 'package:restaurant_app/ui/screen/home/home_screen.dart';
import 'package:restaurant_app/ui/screen/search/search_module.dart';
import 'package:restaurant_app/ui/screen/setting/setting_module.dart';
import 'package:restaurant_app/ui/screen/setting/setting_screen.dart';

import 'ui/screen/search/search_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Restaurant App',
      initialRoute: HomeScreen.routeName,
      enableLog: false,
      getPages: [
        GetPage(
            name: HomeScreen.routeName,
            page: () => HomeScreen(),
            binding: HomeModule()),
        GetPage(
            name: SearchScreen.routeName,
            page: () => SearchScreen(),
            binding: SearchModule()),
        GetPage(
            name: RestaurantDetailScreen.routeName,
            page: () => RestaurantDetailScreen(),
            binding: RestaurantDetailModule()),
        GetPage(
            name: FavoriteScreen.routeName,
            page: () => FavoriteScreen(),
            binding: FavoriteModule()),
        GetPage(
            name: SettingScreen.routeName,
            page: () => SettingScreen(),
            binding: SettingModule())
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
