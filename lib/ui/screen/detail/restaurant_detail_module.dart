import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_controller.dart';

class RestaurantDetailModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantDetailController(Get.find<ApiService>()),
        fenix: true);
  }
}
