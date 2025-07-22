import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/enum/request_type.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_search_field.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/presentation/bloc/today_request_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/presentation/bloc/today_request_event.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/presentation/bloc/today_request_state.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/presentation/widgets/requests_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';

class TodayRequests extends StatefulWidget {
  final RequestType type;
  const TodayRequests({super.key, required this.type});

  @override
  State<TodayRequests> createState() => _TodayRequestsState();
}

class _TodayRequestsState extends State<TodayRequests> {
  final bloc = sl<TodayRequestBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialTodayRequests(type: widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: widget.type.title,
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomSearchField(
            icon: Icons.search,
            hintText: "Search",
            onChanged: (p0) => bloc.add(SearchTodayRequests(p0, widget.type)),
          ),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<TodayRequestBloc, TodayRequestState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchInitialTodayRequests(type: widget.type));
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
                        "No Requests Found.",
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
                        bloc.add(FetchMoreTodayRequests(type: widget.type));
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
                          final request = state.fetchResponse.data![index];
                          return RequestsCard(request: request);
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
