import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/entities/queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/bloc/queries_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/bloc/queries_event.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/bloc/queries_state.dart';
import '/core/utils/general_extentions.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class QueryDetails extends StatefulWidget {
  final QueriesItem query;
  const QueryDetails({super.key, required this.query});

  @override
  State<QueryDetails> createState() => _QueryDetailsState();
}

class _QueryDetailsState extends State<QueryDetails> {
  final TextEditingController replyC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Query Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsRow(title: "Full Name", value: widget.query.name),
              DetailsRow(title: "Email Address", value: widget.query.email),
              DetailsRow(title: "Subject", value: widget.query.subject),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.borderColor.withSafeOpacity(.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.query.text),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (widget.query.action == 'none') ...[
                Text("Your Reply",
                    style: TextStyle(
                        color: AppColors.darkOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                CustomInputField(
                  hintText: "Type your message",
                  controller: replyC,
                ),
                SizedBox(height: 20),
                BlocConsumer<QueriesBloc, QueriesState>(
                  bloc: context.read<QueriesBloc>(),
                  listener: (context, state) {
                    if (state.replyResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                          message: state.replyResponse.message.toString());
                    }
                    if (state.replyResponse.status == Status.completed) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              if (replyC.text.isNotEmpty) {
                                context.read<QueriesBloc>().add(
                                      ReplyQuery(
                                        ReplyQueryParms(
                                          id: widget.query.reqId,
                                          message: replyC.text,
                                        ),
                                      ),
                                    );
                              }
                            },
                            text: "Sent Reply",
                            isLoading:
                                state.replyResponse.status == Status.loading,
                            bgColor: Colors.red,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
