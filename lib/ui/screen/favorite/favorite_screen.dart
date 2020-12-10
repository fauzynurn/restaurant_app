import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/ui/restaurant_item.dart';
import 'package:restaurant_app/ui/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/ui/screen/favorite/favorite_controller.dart';
import 'package:restaurant_app/ui/screen/result.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          pinned: true,
          centerTitle: true,
          title: Text(
            'Your Favorite Resto',
            style: GoogleFonts.oxygen(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w900),
          ),
        ),
        SliverFillRemaining(
          child: Obx(() {
            if (controller.favoriteList.status == Status.LOADING) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.favoriteList.status == Status.COMPLETED) {
              if (controller.favoriteList.data.isNotEmpty) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    itemCount: controller.favoriteList.data.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(RestaurantDetailScreen.routeName,
                              arguments:
                                  controller.favoriteList.data[index].id);
                        },
                        child: RestaurantItem(
                            controller.favoriteList.data[index])),
                    separatorBuilder: (ctx, index) => SizedBox(
                          height: 18,
                        ));
              } else {
                return Center(child: Text('No data'));
              }
            } else {
              return Center(child: Text(controller.favoriteList.message));
            }
          }),
        )
      ]),
    );
  }
}
