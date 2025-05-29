import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/skaleton/presentation/bloc/cubit/skaleton_cubit.dart';
import '/core/widgets/curved_container.dart';
import '/config/constants/colors.dart';
import 'widgets/monthly_card.dart';
import 'widgets/today_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: false,
            floating: true,
            backgroundColor: AppColors.darkOrange,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Master Panel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CurvedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  sectionTitle("Today's Overview"),
                  const SizedBox(height: 12),
                  AdminTodayCard(
                    title: "Today's Requests",
                    onTap: () => context.read<SkaletonCubit>().changeTab(2)
                  ),
                  const SizedBox(height: 10),
                  AdminTodayCard(
                    title: "Today's Queries",
                    approvedLabel: '2 Replied',
                    onTap: () => context.read<SkaletonCubit>().changeTab(3)
                  ),
                  const SizedBox(height: 20),
                  sectionTitle("Monthly Overview"),
                  const SizedBox(height: 12),
                  AdminMonthlyCard(title: 'Monthly Requests (April 2025)'),
                  const SizedBox(height: 10),
                  AdminMonthlyCard(
                    title: 'Monthly Queries (April 2025)',
                    approvedLabel: '13 Replied',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
