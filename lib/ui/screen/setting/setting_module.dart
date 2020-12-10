import 'package:get/get.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/screen/setting/setting_controller.dart';

class SettingModule extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController(Get.find<LocalDataSource>()));
  }

}