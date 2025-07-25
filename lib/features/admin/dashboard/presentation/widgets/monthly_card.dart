import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import '/features/skaleton/cubit/skaleton_cubit.dart';
import '../../../../../config/constants/colors.dart';
import '/core/utils/general_extentions.dart';

class AdminMonthlyCard extends StatelessWidget {
  final String title;
  final AdminRequestQueryEntity data;

  const AdminMonthlyCard({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(title.contains("Requests")){
          context.read<SkaletonCubit>().changeTab(4);
        }else{
          context.read<SkaletonCubit>().changeTab(5);
        }
      },
      child: Card(
        elevation: 0,
        color: const Color(0XFFEDD2C8),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(${DateTime.now().monthYear})",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          data.total.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 6.0,
                        percent:
                            data.total == 0 ? 0.0 : data.approved / data.total,
                        animation: true,
                        backgroundColor: AppColors.pending,
                        progressColor: Colors.green,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.approved.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 3),
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
                            style:
                                TextStyle(color: AppColors.pending, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
