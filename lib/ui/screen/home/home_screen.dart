import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/ui/restaurant_item.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/ui/screen/search/search_screen.dart';

import '../result.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          pinned: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Text(
                  'Perfect Romantic Resto For You',
                  style: GoogleFonts.oxygen(
                      fontSize: 17, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          title: GestureDetector(
              onTap: () {
                Get.toNamed(SearchScreen.routeName);
              },
              child: Hero(tag: 'search-bar', child: _buildSearchBar())),
        ),
        SliverFillRemaining(
          child: Obx(() {
            if (controller.restaurantList.status == Status.LOADING) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.restaurantList.status == Status.COMPLETED) {
              return ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  itemCount: controller.restaurantList.data.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(RestaurantDetail.routeName,
                            arguments: controller.restaurantList.data[index]);
                      },
                      child: RestaurantItem(
                          controller.restaurantList.data[index])),
                  separatorBuilder: (ctx, index) => SizedBox(
                        height: 18,
                      ));
            } else {
              return Center(child: Text(controller.restaurantList.message));
            }
          }),
        )
      ]),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Search restaurant or cuisine',
                style: GoogleFonts.oxygen(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              Icons.search_rounded,
              size: 20,
              color: Colors.grey.shade500,
            )
          ],
        ),
      ),
    );
  }
}
