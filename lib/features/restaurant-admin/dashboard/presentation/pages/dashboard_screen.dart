import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/widgets/loading_widget.dart';
import '/features/restaurant-admin/dashboard/domain/entities/dashboard.dart';
import '/features/restaurant-admin/dashboard/presentation/bloc/dashboard_event.dart';
import '/features/restaurant-admin/dashboard/presentation/bloc/dashboard_state.dart';
import '/features/restaurant-admin/dashboard/presentation/widgets/today_card.dart';
import '/core/widgets/themed_app_bar.dart';
import '/dependency_injection.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl<DashboardBloc>();
    _bloc.add(FetchDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: ThemedAppBar(title: "Dashboard"),
        backgroundColor: AppColors.darkOrange,
        body: CurvedContainer(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: LoadingWidget());
              } else if (state is DashboardSuccess) {
                return buildDashboardContent(context, state.data);
              } else if (state is DashboardError) {
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
      BuildContext context, DashboardEntity data) {
    return RefreshIndicator.adaptive(
      onRefresh: ()async{
        _bloc.add(FetchDashboard());
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Today's Overview"),
            const SizedBox(height: 12),
            DashboardCard(
              title: "Today’s Reservations",
              count: data.todayStats.reservationCount,
              icon: Icons.event_available,
              bgColor: Colors.white,
            ),
            const SizedBox(height: 10),
            DashboardCard(
              title: "Today's Guests",
              count: data.todayStats.totalGuests,
              icon: Icons.group,
              bgColor: Colors.white,
            ),
            const SizedBox(height: 20),
            sectionTitle("Monthly Overview"),
            const SizedBox(height: 12),
            DashboardCard(title: "Reservations | This Month",
            count: data.monthlyStats.reservationCount,
            icon: Icons.date_range,
            bgColor: Color(0XFFEDD2C8),
             ),
            const SizedBox(height: 10),
            DashboardCard(title: "Total Guests | This Month",
            count: data.monthlyStats.totalGuests,
            icon: Icons.groups,
            bgColor: Color(0XFFEDD2C8),
            ),
            const SizedBox(height: 20),
            sectionTitle("Overall Statistics"),
            const SizedBox(height: 12),
            DashboardCard(title: "Total Reservations",
            count: data.overallStats.reservationCount,
            icon: Icons.assignment_turned_in,
            bgColor: Color(0XFFF4E2B8),
             ),
            const SizedBox(height: 10),
            DashboardCard(title: "Total Guests",
            count: data.overallStats.totalGuests,
            icon: Icons.people_alt,
            bgColor: Color(0XFFF4E2B8),
            ),
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
