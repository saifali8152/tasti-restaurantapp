import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/constants/colors.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_event.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_state.dart';
import '/core/utils/general_extentions.dart';

class CsvDataCard extends StatelessWidget {
  final CustomerReservationsBloc bloc;
  final CSVDataEntity data;

  const CsvDataCard({super.key, required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerReservationsBloc, CustomerReservationsState>(
      bloc: bloc,
      builder: (context, state) {
        final isSelected =
            state.selectedCVCRevervations.any((e) => e.id == data.id);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppColors.darkOrange.withSafeOpacity(.7)
                  : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              bloc.add(
                ToggleCSVReservationSelectionEvent(data),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Top row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vertical accent bar
                      Container(
                        width: 4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.darkOrange.withSafeOpacity(.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Main info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (data.email.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  data.email,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (data.phone.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  data.phone,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Checkbox
                      Checkbox(
                        value: isSelected,
                        onChanged: (_) {
                          bloc.add(
                            ToggleCSVReservationSelectionEvent(data),
                          );
                        },
                        checkColor: Colors.white,
                        activeColor: AppColors.darkOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade200, thickness: 1),

                  // Stats row (using CSV fields)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(Icons.location_city, "City", data.city),
                      _buildStat(Icons.map, "Province", data.province),
                      _buildStat(Icons.flag, "Country", data.country),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Icon(icon, color: AppColors.darkOrange, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
