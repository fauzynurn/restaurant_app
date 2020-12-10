import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/screen/result.dart';

class HomeController extends GetxController {
  final ApiService _service;
  
  HomeController(this._service);

  final _restaurantList = Rx<Result<List<Restaurant>>>(Result.loading());

  Result<List<Restaurant>> get restaurantList => _restaurantList.value;

  @override
  void onInit() {
    super.onInit();

    _service.getRestaurantList().then(
        (value) =>
        _restaurantList.value = Result.completed(value.restaurants),
        onError: (error) {
      if (error is DioError) {
        if (error is SocketException) {
          _restaurantList.value =
              Result.error('There is a problem with the internet connection');
        } else {
          _restaurantList.value = Result.error('Data cannot be fetched');
        }
      }else{
        _restaurantList.value = Result.error(_restaurantList.value.message);
      }
    });
  }
}
