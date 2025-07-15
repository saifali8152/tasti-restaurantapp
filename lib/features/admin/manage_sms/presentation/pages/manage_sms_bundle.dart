import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/routes/route_name.dart';
import '/config/constants/icons.dart';
import '/core/widgets/icon_button.dart';
import '../widgets/manage_sms_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class ManageSMS extends StatelessWidget {
  const ManageSMS({super.key});

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
              onTap: ()=> context.push(AppRoutes.addSmsBundle),
              bgColor: Color(0xFF0D49AA),
            ),
            ButtonWithIcon(
              icon:
                  Image.asset(AppIcons.target, color: Colors.white, height: 15),
              title: 'Transaction History',
              onTap: ()=> context.push(AppRoutes.transactionHistory),
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
      body: CurvedContainer(
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return ManageSMSCard();
          },
        ),
      ),
    );
  }
}
