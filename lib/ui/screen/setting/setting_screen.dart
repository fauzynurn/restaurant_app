import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/ui/screen/setting/setting_controller.dart';

class SettingScreen extends GetView<SettingController> {
  static const routeName = '/setting';

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
            title: Text(
              'Settings',
              style: GoogleFonts.oxygen(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
              child: Obx(() => SwitchListTile(
                    title: Text(
                      "Restaurant notification",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    subtitle: Text(
                      "Random restaurant every 11 AM",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    value: controller.restaurantNotification,
                    onChanged: (value) =>
                        controller.setRestaurantNotification(value),
                  ))),
        ]));
  }
}
