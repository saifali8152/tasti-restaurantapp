import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/widgets/loading_widget.dart';
import '/core/widgets/themed_app_bar.dart';
import '/dependency_injection.dart';
import '/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '../bloc/admin_dashboard_bloc.dart';
import '../bloc/admin_dashboard_event.dart';
import '../bloc/admin_dashboard_state.dart';
import '../widgets/monthly_card.dart';
import '../widgets/today_card.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late AdminDashboardBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl<AdminDashboardBloc>();
    _bloc.add(FetchAdminDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: ThemedAppBar(title: "Master Panel"),
        backgroundColor: AppColors.darkOrange,
        body: CurvedContainer(
          child: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
            builder: (context, state) {
              if (state is AdminDashboardLoading) {
                return const Center(child: LoadingWidget());
              } else if (state is AdminDashboardSuccess) {
                return buildDashboardContent(context, state.data);
              } else if (state is AdminDashboardError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget buildDashboardContent(
      BuildContext context, AdminDashboardEntity data) {
    return RefreshIndicator(
      onRefresh: ()async{
        _bloc.add(FetchAdminDashboard());
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Today's Overview"),
            const SizedBox(height: 12),
            AdminTodayCard(
              title: "Today’s Requests",
              data: data.today.requests,
            ),
            const SizedBox(height: 10),
            AdminTodayCard(
              title: "Today's Queries",
              data: data.today.queries,
            ),
            const SizedBox(height: 20),
            sectionTitle("Monthly Overview"),
            const SizedBox(height: 12),
            AdminMonthlyCard(title: "Monthly Requests" ,data: data.monthly.requests),
            const SizedBox(height: 10),
            AdminMonthlyCard(title: "Monthly Queries",data: data.monthly.queries),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
