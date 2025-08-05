import 'package:flutter/widgets.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/header_cell.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/entities/venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/widgets/delete_venue_dialog.dart';

class VenueData extends StatelessWidget {
  final VenueEntity venue;
  final String id;
  const VenueData({
    super.key,
    required this.id,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 30,
                  bottom: 5,
                  left: 10,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.tileHeader,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: const [
                    HeaderCell('Name'),
                    Spacer(),
                    HeaderCell('Created On'),
                    Spacer(),
                    HeaderCell('Actions'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 10,
                  bottom: 5,
                  left: 10,
                ),
                color: AppColors.background,
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        venue.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Text(
                        venue.date,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 30,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomButton(
                          onPressed: () {
                            context.showCustomDialog(DeleteVenueDialog(
                              id: venue.venueId.toString(),
                            ));
                          },
                          text: "Delete",
                          isFullWidth: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
