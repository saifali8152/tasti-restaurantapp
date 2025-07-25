import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/features/admin/requests/presentation/bloc/request_bloc.dart';
import '/features/admin/requests/presentation/widgets/decline_request_dialog.dart';
import '../../domain/entities/requests.dart';
import '/config/routes/route_name.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class RequestsCard extends StatelessWidget {
  final bool isVerified;
  final RequestItem? request;
  final RequestBloc bloc;
  const RequestsCard({super.key, this.isVerified = false, this.request, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,AppRoutes.requestDetails, arguments: {'request': request, 'bloc': bloc});
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request?.name ?? 'N/A',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              request?.role ?? 'N/A',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              request?.dateFormatted ?? 'N/A',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    request?.city ?? 'N/A',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            if (!isVerified && request?.action == 'no') ...[
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: ()=> context.showCustomDialog(DeclineRequestDialog(id: request!.reqId.toString(), bloc: bloc)),
                      text: "Decline",
                      bgColor: Colors.transparent,
                      borderColor: AppColors.darkOrange,
                      textColor: AppColors.darkOrange,
                      isFullWidth: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      text: "Accept",
                      isFullWidth: false,
                    ),
                  )
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
