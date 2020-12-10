import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/screen/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModule extends Bindings {
  @override
  void dependencies() async {
    Get.put(provideDio());
    Get.put(ApiService(Get.find<Dio>()));
    Get.put(HomeController(Get.find<ApiService>()));
    final pref = await Get.putAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
    Get.put(LocalDataSource(pref));
  }

  Dio provideDio() =>
      Dio(BaseOptions(baseUrl: 'https://developers.zomato.com/api/v2.1/'))
        ..interceptors.add(InterceptorsWrapper(onError: (error) {
          debugPrint(error.response.toString());
        }));
}
