import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/ui/component/rating_star.dart';
import 'package:restaurant_app/ui/screen/result.dart';

import 'restaurant_detail_controller.dart';

class RestaurantDetail extends GetView<RestaurantDetailController> {
  static const routeName = '/restaurant-detail';

  RestaurantDetail();

  Restaurant get restaurant => controller.restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            restaurant.name,
            style: GoogleFonts.oxygen(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Hero(
                    tag: restaurant.id,
                    child: FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.fill,
                        imageErrorBuilder: (BuildContext context, Object error,
                                StackTrace stackTrace) =>
                            Image.asset(
                              'assets/placeholder.png',
                              height: 250,
                            ),
                        placeholder: 'assets/placeholder.png',
                        image: restaurant.featuredImage)),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      restaurant.name,
                      style: GoogleFonts.oxygen(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      restaurant.location.localityVerbose,
                      style: GoogleFonts.oxygen(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(restaurant.cuisines),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        _buildRating(restaurant.userRating),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                            '(${restaurant.allReviewsCount.toString()} Reviews)')
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Text('Opens at',
                        style: GoogleFonts.oxygen(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(child: Text(restaurant.timings)),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Text('Highlights',
                        style: GoogleFonts.oxygen(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                        direction: Axis.horizontal,
                        spacing: 6,
                        children: restaurant.highlights
                            .map((item) => _buildHighlightItem(item))
                            .toList()),
                    SizedBox(
                      height: 22,
                    ),
                    Text('Reviews & Ratings',
                        style: GoogleFonts.oxygen(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: restaurant.userRating.aggregateRating
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 18)),
                              TextSpan(
                                  text: '/10',
                                  style: TextStyle(color: Colors.black))
                            ])),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(int.parse(
                                      "0xff${restaurant.userRating.ratingColor}"))
                                  .withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Text(
                                restaurant.userRating.ratingText,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      if (controller.reviewList.status == Status.LOADING) {
                        return Center(child: CircularProgressIndicator());
                      } else if (controller.reviewList.status ==
                          Status.COMPLETED) {
                        return Column(
                            children: controller.reviewList.data
                                .map((item) => _buildReviewItem(item))
                                .toList());
                      } else {
                        return Text(controller.reviewList.message);
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHighlightItem(String highlight) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          highlight,
          style: TextStyle(fontSize: 12),
        ),
      ),
      color: Colors.grey.shade300,
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(mainAxisSize: MainAxisSize.max, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                image: review.user.profileImage,
                height: 40,
                width: 40,
                imageErrorBuilder: (BuildContext context, Object error,
                        StackTrace stackTrace) =>
                    Image.asset(
                  'assets/placeholder.png',
                  height: 250,
                ),
                placeholder: 'assets/placeholder.png',
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.user.name,
                      style: GoogleFonts.oxygen(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  RatingStar(review.rating, 16)
                ],
              ),
            ),
            Text(review.reviewTimeFriendly,
                style: TextStyle(fontWeight: FontWeight.w600))
          ]),
          SizedBox(
            height: 12,
          ),
          Text(
            review.ratingText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            review.reviewText,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(UserRating rating) {
    return Container(
      decoration: BoxDecoration(
          color: Color(int.parse("0xff${rating.ratingColor}")).withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(int.parse("0xff${rating.ratingColor}")),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  rating.aggregateRating.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              rating.ratingText,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ))
        ],
      ),
    );
  }
}
