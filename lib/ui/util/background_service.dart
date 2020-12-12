import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/ui/util/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final dio = provideDio();
    final NotificationHelper _notificationHelper =
        NotificationHelper(dio, FlutterLocalNotificationsPlugin());
    var result = await ApiService(dio).getRestaurantList();
    await _notificationHelper.showNotification(
        FlutterLocalNotificationsPlugin(),
        result.restaurants[Random().nextInt(result.restaurants.length)]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  static Dio provideDio() =>
      Dio(BaseOptions(baseUrl: 'https://developers.zomato.com/api/v2.1/'))
        ..interceptors.add(InterceptorsWrapper(onError: (error) {
          debugPrint(error.response.toString());
        }));
}
