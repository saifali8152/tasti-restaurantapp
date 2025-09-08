import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_state.dart';
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
import '../widgets/restaurant_user_card.dart';

class RestaurantUserScreen extends StatefulWidget {
  const RestaurantUserScreen({super.key});

  @override
  State<RestaurantUserScreen> createState() => _RestaurantUserScreenState();
}

class _RestaurantUserScreenState extends State<RestaurantUserScreen> {
  final RestaurantUserBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchRestaurantUserEvent(id.toString()));
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
        title: "User Permissions",
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
        child: BlocBuilder<RestaurantUserBloc, RestaurantUserState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchRestaurantUserEvent(id.toString()));
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
                      return _messageList("Nothing Found.");
                    }

                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return RestaurantUserCard(item: item);
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
