import 'package:flutter/material.dart';
import '/features/admin/campaigns/presentation/bloc/campaign/campaign_bloc.dart';
import '/features/admin/campaigns/presentation/bloc/campaign/campaign_event.dart';
import '/features/admin/campaigns/presentation/bloc/campaign/campaign_state.dart';
import '/features/admin/campaigns/presentation/widgets/marketing_campaign_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';

class MarketingCampain extends StatefulWidget {
  const MarketingCampain({super.key});

  @override
  State<MarketingCampain> createState() => _MarketingCampainState();
}

class _MarketingCampainState extends State<MarketingCampain> {
  final bloc = sl<CampaignBloc>();
  @override
  void initState() {
    bloc.add(FetchCampaigns());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 60,
        title: "Marketing Campaign",
      ),
      body: CurvedContainer(
        child: BlocBuilder<CampaignBloc, CampaignState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchCampaigns());
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
                        "No Campaign Found.",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    );
                  }

                  return ListView.separated(
                      itemCount: state.fetchResponse.data!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index < state.fetchResponse.data!.length) {
                          final campaign = state.fetchResponse.data![index];
                          return MarketingcampaignCard(campaign: campaign);
                        } else {
                          return const Center(child: LoadingWidget());
                        }
                      },
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
