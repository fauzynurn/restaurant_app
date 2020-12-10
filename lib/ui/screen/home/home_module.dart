import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/screen/home/home_controller.dart';

class HomeModule extends Bindings {
  @override
  void dependencies() {
    Get.put(provideDio());
    Get.put(ApiService(Get.find<Dio>()));
    Get.put(HomeController(Get.find<ApiService>()));
    Get.put(LocalDataSource());
  }

  Dio provideDio() =>
      Dio(BaseOptions(baseUrl: 'https://developers.zomato.com/api/v2.1/'))
        ..interceptors.add(InterceptorsWrapper(onError: (error) {
          debugPrint(error.response.toString());
        }));
}
