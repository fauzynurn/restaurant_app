import 'package:get/get.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';
import 'package:restaurant_app/ui/screen/result.dart';

class FavoriteController extends GetxController {
  final LocalDataSource _local;

  FavoriteController(this._local);

  final _favoriteList = Rx<Result<List<Restaurant>>>(Result.loading());

  Result<List<Restaurant>> get favoriteList => _favoriteList.value;

  @override
  void onInit() {
    super.onInit();
    _local.getFavoriteRestaurant().then(
        (value) => _favoriteList.value = Result.completed(value),
        onError: (error) => Result.error(error.toString()));
  }
}
