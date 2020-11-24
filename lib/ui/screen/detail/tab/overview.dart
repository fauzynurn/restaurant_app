import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/data/model/restaurant.dart';

class Overview extends StatelessWidget {
  final Restaurant restaurant;

  Overview(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 13),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(232, 240, 245, 1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      size: 18,
                                    )),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "LOCATION",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              restaurant.city,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.star,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      size: 18,
                                    )),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "RATING",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.rice_bowl_sharp,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      size: 18,
                                    )),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "TOTAL FOOD",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              restaurant.menu.foods.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.local_drink,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      size: 18,
                                    )),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "TOTAL DRINK",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(144, 161, 171, 1),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              restaurant.menu.drinks.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            restaurant.desc,
            style: TextStyle(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
