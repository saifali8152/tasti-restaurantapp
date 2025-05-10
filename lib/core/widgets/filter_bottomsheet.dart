import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';
import 'ratings_row.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';

class FilterBottomsheet extends StatelessWidget {
  const FilterBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Filter By',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 10),
                Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomInputField(
                  hintText: 'Search location',
                  icon: Icons.map,
                  radius: 12,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$0 - \$100'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RangeSlider(
              min: 0,
              max: 100,
              onChanged: (RangeValues values) {},
              values: RangeValues(0, 100),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rating',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RatingsRow(),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                CustomButton(
                  onPressed: () {},
                  text: 'Apply filter',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
