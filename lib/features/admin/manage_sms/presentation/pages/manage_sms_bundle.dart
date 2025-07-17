import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_event.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_state.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/widgets/manage_sms_card.dart';
import '/config/routes/route_name.dart';
import '/config/constants/icons.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class ManageSMS extends StatefulWidget {
  const ManageSMS({super.key});

  @override
  State<ManageSMS> createState() => _ManageSMSState();
}

class _ManageSMSState extends State<ManageSMS> {
  final bloc = sl<FetchAdminSmsBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialAdminSms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 180,
        title: "Manage SMS Bundles",
        subTitle: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ButtonWithIcon(
              icon: Image.asset(AppIcons.envelop,
                  color: Colors.white, height: 15),
              title: 'Add SMS Bundles',
              onTap: () => context.push(AppRoutes.addSmsBundle),
              bgColor: Color(0xFF0D49AA),
            ),
            ButtonWithIcon(
              icon:
                  Image.asset(AppIcons.target, color: Colors.white, height: 15),
              title: 'Transaction History',
              onTap: () => context.push(AppRoutes.transactionHistory),
              bgColor: Color(0xFF5A73E2),
            ),
            ButtonWithIcon(
              icon:
                  Image.asset(AppIcons.target, color: Colors.white, height: 15),
              title: 'Manage Fees',
              onTap: () {},
              bgColor: Color(0xFF2EBABA),
            ),
          ],
        ),
      ),
      body: BlocBuilder<FetchAdminSmsBloc, FetchAdminSmsLoaded>(
        bloc: bloc,
        builder: (context, state) {
          return CurvedContainer(
            child: RefreshIndicator.adaptive(
              onRefresh: ()async{
                bloc.add(FetchInitialAdminSms());
              },
              child: Builder(
                builder: (context) {
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
                          "No SMS Bundle Found.",
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
                          bloc.add(FetchMoreAdminSms());
                        }
                        return false;
                      },
                      child: ListView.separated(
                        itemCount:
                            state.fetchResponse.data!.length + (state.isLoadingMore ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index < state.fetchResponse.data!.length) {
                            final smsItem = state.fetchResponse.data![index];
                            return ManageSMSCard(smsItem: smsItem);
                          } else {
                            return const Center(child: LoadingWidget());
                          }
                        },
                      ),
                    );
                  }
              
                  return const Center(child: Text("Something went wrong."));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
