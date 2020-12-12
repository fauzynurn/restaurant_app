import 'dart:convert';

class RestaurantListResponse {
  RestaurantListResponse({
    this.resultsShown,
    this.restaurants,
  });

  final int resultsShown;
  final List<Restaurant> restaurants;

  factory RestaurantListResponse.fromRawJson(String str) =>
      RestaurantListResponse.fromJson(json.decode(str));

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      resultsShown: json["results_shown"],
      restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x['restaurant']))),
    );
  }
}

class RestaurantResponse {
  RestaurantResponse({
    this.restaurant,
  });

  final RestaurantDetail restaurant;

  factory RestaurantResponse.fromRawJson(String str) =>
      RestaurantResponse.fromJson(json.decode(str));

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );
}

class RestaurantDetail {
  RestaurantDetail({
    this.id,
    this.name,
    this.location,
    this.timings,
    this.averageCostForTwo,
    this.priceRange,
    this.featuredImage,
    this.currency,
    this.cuisines,
    this.highlights,
    this.thumb,
    this.userRating,
    this.allReviewsCount,
    this.phoneNumbers,
    this.establishment,
  });

  final String id;
  final String name;
  final Location location;
  final String timings;
  final int averageCostForTwo;
  final int priceRange;
  final String currency;
  final String cuisines;
  final String featuredImage;
  final List<String> highlights;
  final String thumb;
  final UserRating userRating;
  final int allReviewsCount;
  final String phoneNumbers;
  final List<String> establishment;

  factory RestaurantDetail.fromRawJson(String str) =>
      RestaurantDetail.fromJson(json.decode(str));

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json["id"],
      name: json["name"],
      location: Location.fromJson(json["location"]),
      timings: json["timings"],
      averageCostForTwo: json["average_cost_for_two"],
      priceRange: json["price_range"],
      currency: json["currency"],
      featuredImage: json['featured_image'],
      cuisines: json["cuisines"],
      highlights: List<String>.from(json["highlights"].map((x) => x)),
      thumb: json["thumb"],
      userRating: UserRating.fromJson(json["user_rating"]),
      allReviewsCount: json["all_reviews_count"],
      phoneNumbers: json["phone_numbers"],
      establishment: List<String>.from(json["establishment"].map((x) => x)),
    );
  }
}

class Restaurant {
  Restaurant(
      {this.id,
      this.name,
      this.averageCostForTwo,
      this.cuisines,
      this.thumb,
      this.simpleRating});

  final String id;
  final String name;
  final int averageCostForTwo;
  final String cuisines;
  final String thumb;
  final String simpleRating;

  factory Restaurant.fromMap(Map<String, dynamic> json) {
    return Restaurant(
        id: json["id"],
        name: json["name"],
        averageCostForTwo: json["average_cost_for_two"],
        cuisines: json["cuisines"],
        thumb: json["thumb"],
        simpleRating: json["user_rating"]);
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json["id"],
        name: json["name"],
        averageCostForTwo: json["average_cost_for_two"],
        cuisines: json["cuisines"],
        thumb: json["thumb"],
        simpleRating: json["user_rating"]["aggregate_rating"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "average_cost_for_two": averageCostForTwo,
        "user_rating": simpleRating,
        "cuisines": cuisines,
        "thumb": thumb,
      };
}

class Location {
  Location({
    this.address,
    this.locality,
    this.city,
    this.cityId,
    this.latitude,
    this.longitude,
    this.zipcode,
    this.countryId,
    this.localityVerbose,
  });

  final String address;
  final String locality;
  final String city;
  final int cityId;
  final String latitude;
  final String longitude;
  final String zipcode;
  final int countryId;
  final String localityVerbose;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] ?? '',
        locality: json["locality"],
        city: json["city"],
        cityId: json["city_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        zipcode: json["zipcode"],
        countryId: json["country_id"],
        localityVerbose: json["locality_verbose"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "locality": locality,
        "city": city,
        "city_id": cityId,
        "latitude": latitude,
        "longitude": longitude,
        "zipcode": zipcode,
        "country_id": countryId,
        "locality_verbose": localityVerbose,
      };
}

class UserRating {
  UserRating(
      {this.aggregateRating, this.votes, this.ratingText, this.ratingColor});

  final String aggregateRating;
  final int votes;
  final String ratingText;
  final String ratingColor;

  factory UserRating.fromRawJson(String str) =>
      UserRating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
      aggregateRating: json["aggregate_rating"].toString(),
      votes: json["votes"],
      ratingText: json["rating_text"],
      ratingColor: json["rating_color"]);

  Map<String, dynamic> toMap() => {
        "aggregate_rating": aggregateRating,
        "votes": votes,
      };
}

extension RestaurantConverter on RestaurantDetail {
  Restaurant toRestaurant() => Restaurant(
      id: this.id,
      name: this.name,
      averageCostForTwo: this.averageCostForTwo,
      cuisines: this.cuisines,
      thumb: this.thumb,
      simpleRating: this.userRating.aggregateRating);
}
