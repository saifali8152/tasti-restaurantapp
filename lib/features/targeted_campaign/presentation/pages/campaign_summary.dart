import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/bloc/targeted_campaign_bloc.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/bloc/targeted_campaign_state.dart';
import 'package:tasti_restaurant_app/features/targeted_campaign/presentation/widgets/init_payment_dialog.dart';
import '/config/constants/icons.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/custom_app_bar.dart';

class CampaignSummary extends StatelessWidget {
  final AddTargetedCampaignParms parms;
  const CampaignSummary({super.key, required this.parms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign Summary'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Recipient: ",
                    style: TextStyle(fontSize: 18, color: Colors.red)),
                Text(
                  parms.people.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ButtonWithIcon(
              onTap: () {
                context.showCustomDialog(
                  InitCampaignPaymentDialog(
                      tempId: int.parse(parms.restaurantId)),
                );
              },
              title: parms.cost.toStringAsFixed(2),
              icon: Image.asset(AppIcons.pay, height: 15),
            ),
            // BlocConsumer<TargetedCampaignBloc, TargetedCampaignState>(
            //   listener: (context, state) {
            //     if (state.initPaymentResponse.status == Status.error) {
            //       context.flushBarErrorMessage(
            //         message: state.initPaymentResponse.message.toString(),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     return ButtonWithIcon(
            //       onTap: () {
            //         context.showCustomDialog(
            //           InitCampaignPaymentDialog(tempId: int.parse(parms.restaurantId)),
            //         );
            //       },
            //       title: parms.cost.toStringAsFixed(2),
            //       icon: Image.asset(AppIcons.pay, height: 15),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
