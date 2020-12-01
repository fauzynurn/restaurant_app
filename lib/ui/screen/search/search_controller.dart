import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/data/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../result.dart';

class SearchController extends GetxController {
  final ApiService _service;

  SearchController(this._service);

  final _searchResult = Rx<Result<List<Restaurant>>>();

  Result<List<Restaurant>> get searchResult => _searchResult.value;

  void searchRestaurant(String query) {
    _searchResult.value = Result.loading();
    _service.searchRestaurant(query).then(
        (value) => _searchResult.value = Result.completed(value.restaurants),
        onError: (error) {
      DioError dioError = error;
      if (dioError.error is SocketException) {
        _searchResult.value =
            Result.error('There is a problem with the internet connection');
      } else {
        _searchResult.value = Result.error('Data cannot be fetched');
      }
    });
  }
}
