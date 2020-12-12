import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_screen.dart';

class NotificationHelper {
  final Dio _client;
  final FlutterLocalNotificationsPlugin _notifPlugin;

  NotificationHelper(this._client, this._notifPlugin);

  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notifPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      Get.toNamed(RestaurantDetailScreen.routeName, arguments: payload);
    });
  }

  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    await _client.download(url, filePath,
        options: Options(responseType: ResponseType.stream));
    return filePath;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant res) async {
    var _channelId = "1";
    var _channelName = "res_app_channel";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: BigPictureStyleInformation(FilePathAndroidBitmap(
            await _downloadAndSaveImage(
                res.thumb, "restaurant_notif_pic.png"))));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var title = "Best Picked Restaurant For You";
    var body = res.name;

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: res.id);
  }
}
