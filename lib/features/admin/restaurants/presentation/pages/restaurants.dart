import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enum/restaurant_filter.dart';
import '/core/network/response.dart';
import '/core/widgets/custom_search_field.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/admin/restaurants/presentation/bloc/restaurant_bloc.dart';
import '/features/admin/restaurants/presentation/bloc/restaurant_event.dart';
import '/features/admin/restaurants/presentation/bloc/restaurant_state.dart';
import '../widgets/restaurant_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({super.key});

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  final bloc = sl<RestaurantBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Restaurants",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              return CustomSearchField(
                icon: Icons.search,
                hintText: "Search",
                suffixIcon: DropdownButton<RestaurantFilter>(
                  padding: EdgeInsets.only(right: 20),
                  dropdownColor: Colors.white,
                  underline: SizedBox.shrink(),
                  items: RestaurantFilter.values.map((filter) {
                    final isSelected = filter == state.filter;
                    return DropdownMenuItem(
                      value: filter,
                      child: Text(
                        filter.title,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color:
                              isSelected ? AppColors.darkOrange : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    bloc.add(SetRestaurantFilter(value));
                  },
                  icon: Icon(Icons.sort),
                ),
                onChanged: (p0) => bloc.add(SearchRestaurant(p0)),
              );
            },
          ),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchInitialRestaurant());
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
                        "No Restaurant Found.",
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
                        bloc.add(FetchMoreRestaurant());
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
                          final restaurant = state.fetchResponse.data![index];
                          return RestaurantCard(restaurant: restaurant);
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
