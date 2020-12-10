import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/source/local/local_datasource.dart';

import '../result.dart';

class RestaurantDetailController extends GetxController {
  final ApiService _service;
  final LocalDataSource _local;
  String resId;

  RestaurantDetailController(this._service, this._local);

  final _review = Rx<Result<List<Review>>>(Result.loading());
  final _restaurant = Rx<Result<RestaurantDetail>>(Result.loading());
  final _isFav = Rx<bool>(false);

  Result<List<Review>> get reviewList => _review.value;

  bool get isFav => _isFav.value;

  Result<RestaurantDetail> get restaurant => _restaurant.value;

  void setFavorite() {
    _isFav.value = !_isFav.value;
    if (_isFav.value) {
      _local.addToFavorite(_restaurant.value.data.toRestaurant());
    } else {
      _local.removeFromFavorite(_restaurant.value.data.id);
    }
  }

  @override
  void onInit() {
    super.onInit();
    resId = Get.arguments;
    _service.getRestaurant(resId).then((value) async {
      _isFav.value = await _local.isOnFav(resId);
      _restaurant.value = Result.completed(value);
    }, onError: (error) {
      if (error is DioError) {
        if (error is SocketException) {
          _restaurant.value =
              Result.error('There is a problem with the internet connection');
        } else {
          _restaurant.value = Result.error('Data cannot be fetched');
        }
      }else{
        _restaurant.value = Result.error(_restaurant.value.message);
      }
    });

    _service
        .getReview(resId)
        .then((value) => _review.value = Result.completed(value.userReviews),
            onError: (error) {
              if (error is DioError) {
                if (error is SocketException) {
                  _review.value =
                      Result.error('There is a problem with the internet connection');
                } else {
                  _review.value = Result.error('Data cannot be fetched');
                }
              }else{
                _review.value = Result.error(_review.value.message);
              }
    });
  }
}
