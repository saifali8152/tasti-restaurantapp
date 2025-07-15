import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '../bloc/admin_dashboard_bloc.dart';
import '../bloc/admin_dashboard_event.dart';
import '../bloc/admin_dashboard_state.dart';
import '../widgets/monthly_card.dart';
import '../widgets/today_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminDashboardBloc>(
      create: (context) {
        final bloc = sl<AdminDashboardBloc>();
        bloc.add(FetchAdminDashboard());
        return bloc;
      },
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        body: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
          builder: (context, state) {
            if (state is AdminDashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminDashboardSuccess) {
              return buildDashboardContent(context, state.data);
            } else if (state is AdminDashboardError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildDashboardContent(
      BuildContext context, AdminDashboardEntity data) {
    return CustomScrollView(
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CurvedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                sectionTitle("Today's Overview"),
                const SizedBox(height: 12),
                AdminTodayCard(
                    title: "Today’s Requests", data: data.today.queries),
                const SizedBox(height: 10),
                AdminTodayCard(
                    title: "Today's Queries", data: data.today.requests),
                const SizedBox(height: 20),
                sectionTitle("Monthly Overview"),
                const SizedBox(height: 12),
                AdminMonthlyCard(data: data.monthly.queries),
                const SizedBox(height: 10),
                AdminMonthlyCard(data: data.monthly.requests),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
