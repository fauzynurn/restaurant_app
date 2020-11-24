import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/data/model/stuff.dart';

class Drink extends StatelessWidget {
  final List<Stuff> drinkList;

  Drink(this.drinkList);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Text(drinkList[index].name,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                ),
            separatorBuilder: (context, index) => Divider(height: 2),
            itemCount: drinkList.length),
      ),
    );
  }
}
