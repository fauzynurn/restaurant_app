import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/ui/component/rating_star.dart';
import 'package:restaurant_app/ui/screen/result.dart';

import 'restaurant_detail_controller.dart';

class RestaurantDetailScreen extends GetView<RestaurantDetailController> {
  static const routeName = '/restaurant-detail';

  RestaurantDetailScreen();

  RestaurantDetail get data => controller.restaurant.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            actions: [
              Obx(
                () => controller.restaurant.status != Status.LOADING
                    ? IconButton(
                        icon: Icon(
                          controller.isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: controller.isFav
                              ? Colors.pink.shade300
                              : Colors.black,
                        ),
                        onPressed: () => controller.setFavorite(),
                      )
                    : SizedBox(),
              )
            ],
            backgroundColor: Colors.white,
            title: Obx(
              () => Text(
                controller.restaurant.status == Status.LOADING ? "" : data.name,
                style: GoogleFonts.oxygen(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            )),
        body: Obx(() {
          if (controller.restaurant.status == Status.LOADING) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.restaurant.status == Status.COMPLETED) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Hero(
                        tag: data.id,
                        child: FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.fill,
                            imageErrorBuilder: (BuildContext context,
                                    Object error, StackTrace stackTrace) =>
                                Image.asset(
                                  'assets/placeholder.png',
                                  height: 250,
                                ),
                            placeholder: 'assets/placeholder.png',
                            image: data.featuredImage)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          data.name,
                          style: GoogleFonts.oxygen(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          data.location.localityVerbose,
                          style: GoogleFonts.oxygen(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(data.cuisines),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          children: [
                            _buildRating(data.userRating),
                            SizedBox(
                              width: 6,
                            ),
                            Text('(${data.allReviewsCount.toString()} Reviews)')
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
                            Expanded(child: Text(data.timings)),
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
                            children: data.highlights
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
                                      text: data.userRating.aggregateRating
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
                                          "0xff${data.userRating.ratingColor}"))
                                      .withOpacity(0.7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Text(
                                    data.userRating.ratingText,
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
                        Container(
                            child: (() {
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
                        }()))
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text(controller.restaurant.message));
          }
        }));
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
