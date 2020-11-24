import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/data/model/restaurant.dart';
import 'package:restaurant_app/ui/screen/detail/tab/drink.dart';
import 'package:restaurant_app/ui/screen/detail/tab/food.dart';
import 'package:restaurant_app/ui/screen/detail/tab/overview.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetail(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  brightness: Brightness.light,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Hero(
                        tag: restaurant.id,
                        child: Image.network(
                          restaurant.url,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                SliverPersistentHeader(
                  delegate: RestaurantDetailAppBar(
                    bar: TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Overview"),
                        Tab(text: "Food"),
                        Tab(
                          text: "Drink",
                        )
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(children: [
              Overview(restaurant),
              Food(restaurant.menu.foods),
              Drink(restaurant.menu.drinks)
            ])),
      ),
    );
  }
}

class RestaurantDetailAppBar extends SliverPersistentHeaderDelegate {
  final TabBar bar;

  RestaurantDetailAppBar({this.bar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: bar);
  }

  @override
  double get maxExtent => bar.preferredSize.height;

  @override
  double get minExtent => bar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
