import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class CsvDataCard extends StatefulWidget {
  final CSVDataEntity data;

  const CsvDataCard({
    super.key,
    required this.data,
  });

  @override
  State<CsvDataCard> createState() => _CsvDataCardState();
}

class _CsvDataCardState extends State<CsvDataCard> {
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
          color: _isSelected ? AppColors.darkOrange.withSafeOpacity(.01) : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isSelected ? AppColors.darkOrange.withSafeOpacity(.5) : Colors.transparent,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Checkbox(
              value: _isSelected,
              onChanged: (val) {
                setState(() => _isSelected = val ?? false);
              },
              checkColor: AppColors.darkOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 8),
            // Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardDetailsRow(label: 'Name', value: widget.data.name),
                  CardDetailsRow(label: 'Email', value: widget.data.email),
                  CardDetailsRow(label: 'Phone', value: widget.data.phone),
                  CardDetailsRow(label: 'City', value: widget.data.city),
                  CardDetailsRow(label: 'Province', value: widget.data.province),
                  CardDetailsRow(label: 'Country', value: widget.data.country),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
