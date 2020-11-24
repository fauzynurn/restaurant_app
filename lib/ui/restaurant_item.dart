import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/data/model/restaurant.dart';

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
              child: Image.network(
                restaurant.url,
                fit: BoxFit.fill,
                width: 135,
                height: 100,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 18,
                      )),
                  Text(restaurant.city)
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow.shade600,
                        size: 18,
                      )),
                  Text(restaurant.rating.toString())
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
