import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/util/background_service.dart';

class SettingController extends GetxController {
  final LocalDataSource _local;
  final _restaurantNotification = Rx<bool>(false);

  bool get restaurantNotification => _restaurantNotification.value;

  SettingController(this._local);

  @override
  void onInit() {
    super.onInit();
    _restaurantNotification.value = _local.getRestaurantNotification();
  }

  Future<void> scheduleNotification() async {
    if (_restaurantNotification.value) {
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: getNotificationStartTime(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }

  DateTime getNotificationStartTime() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var formatted = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }

  void setRestaurantNotification(bool value) {
    _restaurantNotification.value = value;
    _local.setRestaurantNotification(value);
    scheduleNotification();
  }
}
