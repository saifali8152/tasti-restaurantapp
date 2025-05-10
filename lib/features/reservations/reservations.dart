import 'package:flutter/material.dart';
import '/features/reservations/widgets/appbar.dart';
import '/features/reservations/widgets/date_picker.dart';
import '/features/reservations/widgets/revervation_card.dart';
import '/config/constants/colors.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      body: CustomScrollView(
        slivers: [
          ReservationsAppBar(),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.bookmark, color: Colors.deepOrange),
                              SizedBox(width: 8),
                              Text(
                                'Total Bookings: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '12',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.people, color:AppColors.darkOrange),
                              SizedBox(width: 8),
                              Text(
                                'Total Pax: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ReservationsDatePicker(),
                    const SizedBox(height: 20),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: 3,
                        itemBuilder: (_, index) => RevervationCard()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
