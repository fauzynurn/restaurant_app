import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_screen.dart';

import '../../restaurant_item.dart';
import '../result.dart';
import 'search_controller.dart';

class SearchScreen extends GetView<SearchController> {
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          pinned: true,
          title: Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                  splashRadius: 20,
                  onPressed: () {
                    Get.back();
                  }),
              Expanded(
                  child: Hero(tag: 'search-bar', child: _buildSearchBar())),
              SizedBox(
                width: 12,
              )
            ],
          ),
        ),
        SliverFillRemaining(
          child: Obx(() {
            if (controller.searchResult != null) {
              if (controller.searchResult.status == Status.LOADING) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.searchResult.status == Status.COMPLETED) {
                if (controller.searchResult.data.isNotEmpty) {
                  return ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      itemCount: controller.searchResult.data.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Get.toNamed(RestaurantDetail.routeName,
                                arguments: controller.searchResult.data[index]);
                          },
                          child: RestaurantItem(
                              controller.searchResult.data[index])),
                      separatorBuilder: (ctx, index) => SizedBox(
                            height: 18,
                          ));
                } else {
                  return Center(child: Text('No result found'));
                }
              } else {
                return Center(child: Text(controller.searchResult.message));
              }
            } else {
              return SizedBox();
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
              child: TextField(
                onSubmitted: (value) => controller.searchRestaurant(value),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: 'Search restaurant',
                    hintStyle: TextStyle(fontSize: 15)),
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
