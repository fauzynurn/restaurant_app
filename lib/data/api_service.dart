import 'dart:io';

import 'package:dio/dio.dart';

import 'model/restaurant.dart';
import 'model/review.dart';

class ApiService {
  final Dio _client;

  ApiService(this._client);

  static const token = '7b0f4cb74534b50c0f080c287cfcd06e';

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    final response = await _client.get('/search',
        options:
            Options(headers: {'accept': 'application/json', 'user-key': token}),
        queryParameters: {'q': query, 'start': 0, 'count': 10});
    if (response.statusCode == HttpStatus.ok) {
      return RestaurantListResponse.fromJson(response.data);
    } else {
      throw Exception('Data cannot be fetched');
    }
  }

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await _client.get('/search',
        options:
            Options(headers: {'accept': 'application/json', 'user-key': token}),
        queryParameters: {
          'entity_id': 11052,
          'entity_type': 'city',
          'start': 0,
          'count': 10,
          'collection_id': 3
        });
    if (response.statusCode == HttpStatus.ok) {
      return RestaurantListResponse.fromJson(response.data);
    } else {
      throw Exception('Data cannot be fetched');
    }
  }

  Future<ReviewResponse> getReview(String resId) async {
    final response = await _client.get('/reviews',
        options:
            Options(headers: {'accept': 'application/json', 'user-key': token}),
        queryParameters: {
          'entity_id': resId,
          'start': 0,
          'count': 5,
        });
    if (response.statusCode == HttpStatus.ok) {
      return ReviewResponse.fromJson(response.data);
    } else {
      throw Exception('Data cannot be fetched');
    }
  }

  Future<RestaurantDetail> getRestaurant(String resId) async {
    final response = await _client.get('/restaurant',
        options:
            Options(headers: {'accept': 'application/json', 'user-key': token}),
        queryParameters: {
          'res_id': resId,
        });
    if (response.statusCode == HttpStatus.ok) {
      return RestaurantDetail.fromJson(response.data);
    } else {
      throw Exception('Data cannot be fetched');
    }
  }
}
