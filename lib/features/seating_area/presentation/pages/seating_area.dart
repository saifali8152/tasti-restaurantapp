import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_bloc.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_event.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_state.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../config/constants/icons.dart';
import '../../../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';
import '../widgets/seating_area_card.dart';

class SeatingAreaScreen extends StatefulWidget {
  const SeatingAreaScreen({super.key});

  @override
  State<SeatingAreaScreen> createState() => _SeatingAreaScreenState();
}

class _SeatingAreaScreenState extends State<SeatingAreaScreen> {
  final SeatingAreaBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSeatingAreaEvent(id.toString()));
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
        title: "Seating Area",
        subTitle: ButtonWithIcon(
          icon: Image.asset(AppIcons.seatingArea,
              color: Colors.white, height: 15),
          title: 'Create Seating Areas',
          onTap: () {},
          bgColor: const Color(0xFF5A73E2),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<SeatingAreaBloc, SeatingAreaState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchSeatingAreaEvent(id.toString()));
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
                        final seatingArea = data[index];
                        return SeatingAreaCard(seatingArea: seatingArea);
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
