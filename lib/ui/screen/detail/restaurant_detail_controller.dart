import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';

import '../result.dart';

class RestaurantDetailController extends GetxController {
  Restaurant _restaurant;

  final ApiService _service;

  RestaurantDetailController(this._service);

  final _review = Rx<Result<List<Review>>>(Result.loading());

  Result<List<Review>> get reviewList => _review.value;

  Restaurant get restaurant => _restaurant;

  @override
  void onInit() {
    super.onInit();
    _restaurant = Get.arguments;
    _service
        .getReview(_restaurant.id)
        .then((value) => _review.value = Result.completed(value.userReviews),
            onError: (error) {
      DioError dioError = error;
      if (dioError.error is SocketException) {
        _review.value =
            Result.error('There is a problem with the internet connection');
      } else {
        _review.value = Result.error('Data cannot be fetched');
      }
    });
  }
}
