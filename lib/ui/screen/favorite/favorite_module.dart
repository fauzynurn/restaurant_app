import 'package:get/get.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/screen/favorite/favorite_controller.dart';

class FavoriteModule extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController(Get.find<LocalDataSource>()));
  }
}
