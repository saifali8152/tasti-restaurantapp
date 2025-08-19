import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_event.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_state.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/pages/csv_sent_campaign.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/widgets/csv_data_card.dart';

class CvcImportedDataScreen extends StatefulWidget {
  const CvcImportedDataScreen({super.key});

  @override
  State<CvcImportedDataScreen> createState() => _CvcImportedDataScreenState();
}

class _CvcImportedDataScreenState extends State<CvcImportedDataScreen> {
  final CustomerReservationsBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchCsvDataEvent(id.toString()));
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
    return BlocConsumer<CustomerReservationsBloc, CustomerReservationsState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.fetchSmsAvailabilityResponse.status == Status.completed) {
          Navigator.pushNamed(
            context,
            AppRoutes.csvSentCampaign,
            arguments: CsvSentCampaignArguments(
              state.selectedCVCRevervations,
              state.fetchSmsAvailabilityResponse.data.toString(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: "CSV Imported Data"),

          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(FetchCsvDataEvent(id.toString()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  if (state.fetchCSVResponse.status == Status.loading) {
                    return const Center(child: LoadingWidget());
                  }

                  if (state.fetchCSVResponse.status == Status.error) {
                    return _messageList(
                      state.fetchCSVResponse.message.toString(),
                      color: Colors.red,
                    );
                  }

                  if (state.fetchCSVResponse.status == Status.completed) {
                    final data = state.fetchCSVResponse.data ?? [];
                    if (data.isEmpty) {
                      return _messageList("Nothing Found.");
                    }

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final csvData = data[index];
                        return CsvDataCard(data: csvData);
                      },
                    );
                  }

                  return _messageList("Something went wrong.");
                },
              ),
            ),
          ),

          /// 👇 Persistent footer with action button
          persistentFooterButtons: state.selectedCVCRevervations.isNotEmpty
              ? [
                  Hero(
                    tag: "Send SMS/Email",
                    child: Material(
                      type: MaterialType.transparency, // keeps it invisible
                      child: SizedBox(
                        width: 200,
                        child: CustomButton(
                          isFullWidth: false,
                          isLoading:
                              state.fetchSmsAvailabilityResponse.status ==
                                  Status.loading,
                          text:
                              "Send SMS/Email (${state.selectedCVCRevervations.length})",
                          onPressed: () {
                            bloc.add(
                              FetchSmsAvailability(
                                FetchSmsAvailabilityParms(
                                  restaurantId: id,
                                  recipients: state
                                      .selectedCVCRevervations.length
                                      .toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ]
              : null,
        );
      },
    );
  }
}
