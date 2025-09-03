import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_event.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_state.dart';
import '/config/routes/route_name.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../../config/constants/icons.dart';
import '../../../../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';
import '../widgets/admin_user_card.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final AdminUserBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchAdminUserEvent(id.toString()));
  }

  Widget _messageList(String message, {Color? color}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 16, color: color ?? Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Admin Users",
        subTitle: ButtonWithIcon(
          icon: Image.asset(AppIcons.seatingArea,
              color: Colors.white, height: 15),
          title: 'Add User',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.addRestaurantUser);
          },
          bgColor: const Color(0xFF5A73E2),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<AdminUserBloc, AdminUserState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchAdminUserEvent(id.toString()));
              },
              child: Builder(
                builder: (context) {
                  if (state.fetchResponse.status == Status.loading) {
                    return const Center(child: LoadingWidget());
                  }

                  if (state.fetchResponse.status == Status.error) {
                    return _messageList(
                      state.fetchResponse.message.toString(),
                      color: Colors.red,
                    );
                  }

                  if (state.fetchResponse.status == Status.completed) {
                    final data = state.fetchResponse.data ?? [];
                    if (data.isEmpty) {
                      return _messageList("No Seating Area Found.");
                    }

                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return AdminUserCard(item: item);
                      },
                    );
                  }

                  return _messageList("Something went wrong.");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
