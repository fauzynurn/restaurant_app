import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  test('parsing restaurant model from map should return expected model', () {
    // arrange
    Map<String, dynamic> restaurantMap = {
      "id": "19028795",
      "name": "Hungrilla",
      "cuisines": "Biryani, Chinese",
      "average_cost_for_two": 200,
      "thumb": "",
      "user_rating": {
        "aggregate_rating": "4.0",
        "rating_text": "Very Good",
        "rating_color": "5BA829",
        "rating_obj": {
          "title": {"text": "4.0"},
          "bg_color": {"type": "lime", "tint": "600"}
        },
        "votes": 5952
      }
    };
    //act
    final Restaurant res = Restaurant.fromJson(restaurantMap);
    // assert
    expect(res.id, "19028795");
    expect(res.name, "Hungrilla");
    expect(res.cuisines, "Biryani, Chinese");
    expect(res.averageCostForTwo, 200);
    expect(res.thumb, "");
    expect(res.simpleRating, "4.0");
  });
}
