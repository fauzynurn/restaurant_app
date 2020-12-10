import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../ui/util/currency_converter.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            color: Colors.grey.shade300,
            child: Hero(
                tag: restaurant.id,
                child: FadeInImage.assetNetwork(
                    width: 135,
                    height: 100,
                    fit: BoxFit.fill,
                    placeholder: 'assets/placeholder.png',
                    imageErrorBuilder: (BuildContext context, Object error,
                            StackTrace stackTrace) =>
                        Image.asset(
                          'assets/placeholder.png',
                          width: 135,
                          height: 100,
                        ),
                    image: restaurant.thumb)),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: GoogleFonts.oxygen(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                Text(
                  restaurant.cuisines,
                  style: GoogleFonts.oxygen(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money_rounded,
                      color: Colors.grey,
                      size: 18,
                    ),
                    Text(
                      '${restaurant.averageCostForTwo.toString().currencyFormat} for two',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                          size: 18,
                        )),
                    Text(restaurant.simpleRating)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
