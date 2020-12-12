import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/screen/result.dart';
import 'package:restaurant_app/ui/util/background_service.dart';
import 'package:restaurant_app/ui/util/notification_helper.dart';

class HomeController extends GetxController {
  final ApiService _service;
  final BackgroundService _bgService;
  final NotificationHelper _notifHelper;

  HomeController(this._service, this._bgService, this._notifHelper);

  final _restaurantList = Rx<Result<List<Restaurant>>>(Result.loading());

  Result<List<Restaurant>> get restaurantList => _restaurantList.value;

  @override
  void onInit() async {
    super.onInit();
    _bgService.initializeIsolate();

    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
    await _notifHelper.initNotifications();
    _service.getRestaurantList().then(
        (value) => _restaurantList.value = Result.completed(value.restaurants),
        onError: (error) {
      if (error is DioError) {
        if (error is SocketException) {
          _restaurantList.value =
              Result.error('There is a problem with the internet connection');
        } else {
          _restaurantList.value = Result.error('Data cannot be fetched');
        }
      } else {
        _restaurantList.value = Result.error(_restaurantList.value.message);
      }
    });
  }
}
