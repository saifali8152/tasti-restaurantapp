import 'package:flutter/material.dart';
import '/core/widgets/custom_app_bar.dart';
import '/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_bloc.dart';
import '/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_event.dart';
import '/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_state.dart';
import '/features/admin/campaigns/presentation/widgets/campaign_by_res_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';

class MarketingCampaignByRes extends StatefulWidget {
  final String id;
  const MarketingCampaignByRes({super.key, required this.id});

  @override
  State<MarketingCampaignByRes> createState() => _MarketingCampaignByResState();
}

class _MarketingCampaignByResState extends State<MarketingCampaignByRes> {
  final bloc = sl<CampaignByResBloc>();
  @override
  void initState() {
    bloc.add(FetchCampaignsByRes(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Marketing Campaign",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CampaignByResBloc, CampaignByResState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchCampaignsByRes(widget.id));
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
                          return CampaignByResCard(campaign: campaign);
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
