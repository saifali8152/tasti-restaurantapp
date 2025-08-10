import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reviews/presentation/bloc/reviews_bloc.dart';
import 'package:tasti_restaurant_app/features/reviews/presentation/bloc/reviews_event.dart';
import 'package:tasti_restaurant_app/features/reviews/presentation/bloc/reviews_state.dart';
import 'tabs_section.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final int id = SessionController().user?.restaurant.id ?? 0;
  final ReviewsBloc bloc = sl();

  @override
  void initState() {
    super.initState();
    bloc.add(FetchReviewsEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        appBar: ThemedAppBar(
          height: 100,
          title: "Reviews",
        ),
        body: CurvedContainer(
          child: BlocBuilder<ReviewsBloc, ReviewsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.fetchResponse.status == Status.loading) {
                return Center(child: LoadingWidget());
              }
              if (state.fetchResponse.status == Status.completed &&
                  state.fetchResponse.data == null) {
                return Center(child: Text("Nothing Found!"));
              }
              if (state.fetchResponse.status == Status.error) {
                return Center(child: Text(state.fetchResponse.message ?? ''));
              }
              return TabsSection(id: id);
            },
          ),
        ),
      ),
    );
  }
}
