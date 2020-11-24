import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_item.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "Restaurant App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurant_list.json'),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            final Map<String, dynamic> decodedJson = jsonDecode(snapshot.data);
            final restaurantList = (decodedJson['restaurants'] as List)
                .map((item) => Restaurant.fromJson(item))
                .toList();
            return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                itemCount: restaurantList.length,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantDetail(restaurantList[index]),
                        ),
                      );
                    },
                    child: RestaurantItem(restaurantList[index])),
                separatorBuilder: (ctx, index) => SizedBox(
                      height: 18,
                    ));
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Text("An error occurred");
            }
          }
        },
      ),
    );
  }
}
