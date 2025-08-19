import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/widgets/icon_button.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

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
  bool _isSelected = false; // internal state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isSelected = !_isSelected);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isSelected
              ? AppColors.darkOrange.withSafeOpacity(.05)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isSelected
                ? AppColors.darkOrange.withSafeOpacity(.7)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withSafeOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with checkbox and details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDetailsRow(
                          label: 'Customer Name',
                          value: widget.data.customerName),
                      CardDetailsRow(
                          label: 'Email',
                          value: widget.data.customerEmail.toString()),
                      CardDetailsRow(
                          label: 'Phone', value: widget.data.customerPhone),
                      CardDetailsRow(
                          label: 'Total Reservations',
                          value: widget.data.reservationCount.toString()),
                      CardDetailsRow(
                          label: 'Last Visit',
                          value: widget.data.lastReservationFormatted),
                      CardDetailsRow(label: 'Type', value: widget.data.type),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Show Details button only if hasEmail is true
            if (widget.data.hasEmail)
              Align(
                alignment: Alignment.centerRight,
                child: ButtonWithIcon(
                  icon: const Icon(Icons.info_outline, size: 20, color: Colors.white),
                  title: "Details",
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.reservationsByEmail, arguments: widget.data.customerEmail);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
