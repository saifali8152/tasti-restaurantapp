import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/constants/colors.dart';
import '/config/routes/route_name.dart';
import '/core/network/response.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/admin/manage_fee/presentation/bloc/get_monthly_fee_bloc.dart';
import '/features/admin/manage_fee/presentation/bloc/get_monthly_fee_event.dart';
import '/features/admin/manage_fee/presentation/bloc/get_monthly_fee_state.dart';

class MonthlyFee extends StatefulWidget {
  const MonthlyFee({super.key});

  @override
  State<MonthlyFee> createState() => _MonthlyFeeState();
}

class _MonthlyFeeState extends State<MonthlyFee> {
  final bloc = sl<AdminMonthlyFeeBloc>();
  @override
  void initState() {
    bloc.add(FetchMonthlyFeeSubmitted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Manage Monthly Fee'),
      body: BlocBuilder<AdminMonthlyFeeBloc, MonthlyFeeState>(
        bloc: bloc,
        builder: (context, state) {
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
            if (state.fetchResponse.data == null) {
              return Center(
                child: Text(
                  "No Montly Fee Found.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Current Monthly Fee",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.darkOrange.withSafeOpacity(.3),
                            borderRadius: BorderRadius.circular(5)),
                        width: double.infinity,
                        child: Center(
                            child: Text(
                                state.fetchResponse.data?.money ?? 'N/A'))),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                          AppRoutes.updateMonthlyFee,
                          arguments: state.fetchResponse.data!.id.toString(),
                        );
                      },
                      text: "Update Fee",
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),
    );
  }
}
