import 'package:flutter/material.dart';
import '../../config/constants/colors.dart';

class RatingsRow extends StatelessWidget {
  const RatingsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingIcon(rating: 1),
        SizedBox(width: 10),
        RatingIcon(rating: 2),
        SizedBox(width: 10),
        RatingIcon(rating: 3),
        SizedBox(width: 10),
        RatingIcon(rating: 4),
                
        SizedBox(width: 10),
        RatingIcon(rating: 5),
      ],
    );
  }
}


class RatingIcon extends StatelessWidget {
  final int rating;
  const RatingIcon({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.star, color: AppColors.yellow),
              ],
            ),
          ),
        );
  }
}
