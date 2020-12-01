import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/ui/screen/search/search_controller.dart';

class SearchModule extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController(Get.find<ApiService>()));
  }
}
