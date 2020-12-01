import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int rating;
  final double size;

  RatingStar(this.rating, this.size);

  final stars = [
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
        children: stars[rating - 1]
            .map((star) => Icon(
                  Icons.star,
                  size: size,
                  color: star == 1 ? Colors.orange : Colors.grey.shade300,
                ))
            .toList());
  }
}
