import 'dart:convert';

class ReviewResponse {
  ReviewResponse({
    this.reviewsCount,
    this.reviewsStart,
    this.reviewsShown,
    this.userReviews,
  });

  final int reviewsCount;
  final int reviewsStart;
  final int reviewsShown;
  final List<Review> userReviews;

  factory ReviewResponse.fromRawJson(String str) =>
      ReviewResponse.fromJson(json.decode(str));

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        reviewsCount: json["reviews_count"],
        reviewsStart: json["reviews_start"],
        reviewsShown: json["reviews_shown"],
        userReviews: List<UserReview>.from(
                json["user_reviews"].map((x) => UserReview.fromJson(x)))
            .map((e) => e.review)
            .toList(),
      );
}

class UserReview {
  UserReview({
    this.review,
  });

  final Review review;

  factory UserReview.fromRawJson(String str) =>
      UserReview.fromJson(json.decode(str));

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview(
        review: Review.fromJson(json["review"]),
      );
}

class Review {
  Review({
    this.rating,
    this.reviewText,
    this.id,
    this.ratingColor,
    this.reviewTimeFriendly,
    this.ratingText,
    this.timestamp,
    this.likes,
    this.user,
    this.commentsCount,
  });

  final int rating;
  final String reviewText;
  final int id;
  final String ratingColor;
  final String reviewTimeFriendly;
  final String ratingText;
  final int timestamp;
  final int likes;
  final User user;
  final int commentsCount;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        reviewText: json["review_text"],
        id: json["id"],
        ratingColor: json["rating_color"],
        reviewTimeFriendly: json["review_time_friendly"],
        ratingText: json["rating_text"],
        timestamp: json["timestamp"],
        likes: json["likes"],
        user: User.fromJson(json["user"]),
        commentsCount: json["comments_count"],
      );
}

class User {
  User({
    this.name,
    this.zomatoHandle,
    this.foodieLevel,
    this.foodieLevelNum,
    this.foodieColor,
    this.profileUrl,
    this.profileImage,
    this.profileDeeplink,
  });

  final String name;
  final String zomatoHandle;
  final String foodieLevel;
  final int foodieLevelNum;
  final String foodieColor;
  final String profileUrl;
  final String profileImage;
  final String profileDeeplink;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        zomatoHandle: json["zomato_handle"],
        foodieLevel: json["foodie_level"],
        foodieLevelNum: json["foodie_level_num"],
        foodieColor: json["foodie_color"],
        profileUrl: json["profile_url"],
        profileImage: json["profile_image"],
        profileDeeplink: json["profile_deeplink"],
      );
}
