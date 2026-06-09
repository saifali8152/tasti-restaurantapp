import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/routes/route_name.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_bloc.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_event.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_state.dart';
import '/features/restaurant-admin/bundle_billings/presentation/widgets/bundle_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../../../config/constants/icons.dart';
import '../../../../../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';

class BundleBillingsScreen extends StatefulWidget {
  const BundleBillingsScreen({super.key});

  @override
  State<BundleBillingsScreen> createState() => _BundleBillingsScreenState();
}

class _BundleBillingsScreenState extends State<BundleBillingsScreen> {
  final BundleBillingBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchInitialBundleBillingEvent(id));
  }

  Widget _buildScrollContent(Widget child) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 160,
        title: "SMS Bundles & Transactions",
        subTitle: Column(
          children: [
            ButtonWithIcon(
              icon: Image.asset(AppIcons.seatingArea,
                  color: Colors.white, height: 15),
              title: 'Transaction History',
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutes.restaurantTransactionHistory);
              },
              bgColor: const Color(0xFF5A73E2),
            ),
            ButtonWithIcon(
              icon: Image.asset(AppIcons.seatingArea,
                  color: Colors.white, height: 15),
              title: 'Buy SMS Bundles',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.buySmsBundles);
              },
              bgColor: const Color(0xFFE26A5A),
            ),
          ],
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<BundleBillingBloc, BundleBillingState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchInitialBundleBillingEvent(id));
              },
              child: Builder(
                builder: (context) {
                  if (state.fetchBundleResponse.status == Status.loading) {
                    return _buildScrollContent(
                      const Center(child: LoadingWidget()),
                    );
                  }

                  if (state.fetchBundleResponse.status == Status.error) {
                    print(
                        "Bundle Billings error: ${state.fetchBundleResponse.message}");
                    return _buildScrollContent(
                      Center(
                        child: Text(
                          state.fetchBundleResponse.message.toString(),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  if (state.fetchBundleResponse.status == Status.completed) {
                    if (state.fetchBundleResponse.data!.isEmpty) {
                      return _buildScrollContent(
                        Center(
                          child: Text(
                            "No Event Found.",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                      );
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!state.isBundleLoadingMore &&
                            state.bundlePagination!.hasNext &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 100) {
                          bloc.add(FetchMoreBundleBillingEvent(id));
                        }
                        return false;
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.fetchBundleResponse.data!.length +
                            (state.isBundleLoadingMore ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index < state.fetchBundleResponse.data!.length) {
                            final bundle =
                                state.fetchBundleResponse.data![index];
                            return BundleCard(bundle: bundle);
                          } else {
                            return const Center(child: LoadingWidget());
                          }
                        },
                      ),
                    );
                  }

                  return _buildScrollContent(
                    const Center(child: Text("Something went wrong.")),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
