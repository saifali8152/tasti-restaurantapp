import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_event.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_state.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/widgets/event_card.dart';
import '/core/widgets/custom_search_field.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final bloc = sl<EventBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEvent);
        },
        child: Icon(Icons.add),
      ),
      appBar: ThemedAppBar(
        height: 120,
        title: "Events",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomSearchField(
            icon: Icons.search,
            hintText: "Search",
            onChanged: (p0) => bloc.add(SearchEvents(p0)),
          ),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<EventBloc, EventState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchInitialEvent());
              },
              child: Builder(builder: (context) {
                if (state.fetchResponse.status == Status.loading) {
                  return const Center(child: LoadingWidget());
                }

                if (state.fetchResponse.status == Status.error) {
                  return Center(
                    child: Text(
                      state.fetchResponse.message.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                if (state.fetchResponse.status == Status.completed) {
                  if (state.fetchResponse.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No Event Found.",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!state.isLoadingMore &&
                          state.pagination!.hasNext &&
                          scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 100) {
                        bloc.add(FetchMoreEvent());
                      }
                      return false;
                    },
                    child: ListView.separated(
                      itemCount: state.fetchResponse.data!.length +
                          (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index < state.fetchResponse.data!.length) {
                          final event = state.fetchResponse.data![index];
                          return EventCard(event: event);
                        } else {
                          return const Center(child: LoadingWidget());
                        }
                      },
                    ),
                  );
                }

                return const Center(child: Text("Something went wrong."));
              }),
            );
          },
        ),
      ),
    );
  }
}
