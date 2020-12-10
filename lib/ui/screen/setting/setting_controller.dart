import 'package:get/get.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';

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

  void setRestaurantNotification(bool value) {
    _restaurantNotification.value = value;
    _local.setRestaurantNotification(value);
  }
}
