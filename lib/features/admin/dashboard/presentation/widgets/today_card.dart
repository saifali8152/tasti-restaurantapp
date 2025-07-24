import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import 'package:tasti_restaurant_app/features/skaleton/cubit/skaleton_cubit.dart';
import '/config/constants/colors.dart';
import '/core/utils/general_extentions.dart';

class AdminTodayCard extends StatelessWidget {
  final String title;
  final AdminRequestQueryEntity data;

  const AdminTodayCard({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(title.contains("Requests")){
          context.read<SkaletonCubit>().changeTab(2);
        }else{
          context.read<SkaletonCubit>().changeTab(3);
        }
      },
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.lightOrange.withSafeOpacity(.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.calendar_today,
                      size: 15,
                      color: AppColors.darkOrange,
                    ),
                  ),
                  const Icon(Icons.open_in_new, color: Colors.grey, size: 20),
                ],
              ),
              const SizedBox(height: 10),
              Text(title.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    data.total.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    data.approved.toString(),
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Approved',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    data.pending.toString(),
                    style: TextStyle(
                        color: AppColors.pending,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 3),
                  const Text(
                    'pending',
                    style: TextStyle(color: AppColors.pending, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
