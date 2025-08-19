import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import '/core/utils/general_extentions.dart';

class CustomerReservationCard extends StatefulWidget {
  final ReservationDataEntity data;

  const CustomerReservationCard({
    super.key,
    required this.data,
  });

  @override
  State<CustomerReservationCard> createState() =>
      _CustomerReservationCardState();
}

class _CustomerReservationCardState extends State<CustomerReservationCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isSelected
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
        onTap: () => setState(() => _isSelected = !_isSelected),
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
                          widget.data.customerName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.data.customerEmail != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.data.customerEmail!,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            widget.data.customerPhone,
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
                    value: _isSelected,
                    onChanged: (val) {
                      setState(() => _isSelected = val ?? false);
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

              // Reservation details row with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(Icons.event_seat, "Reservations",
                      widget.data.reservationCount.toString()),
                  _buildStat(Icons.schedule, "Last Visit",
                      widget.data.lastReservationFormatted),
                  _buildStat(Icons.category, "Type", widget.data.type),
                ],
              ),

              const SizedBox(height: 12),

              // Details button
              if (widget.data.hasEmail)
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkOrange,
                      side: BorderSide(color: AppColors.darkOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text("Details"),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.reservationsByEmail,
                        arguments: widget.data.customerEmail,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
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
