import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/file_picker_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/restaurant_campaigns_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/restaurant_campaigns_event.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/restaurant_campaigns_state.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/widgets/csv_download_button.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/network/response.dart';

class ImportDatabase extends StatefulWidget {
  const ImportDatabase({super.key});

  @override
  State<ImportDatabase> createState() => _ImportDatabaseState();
}

class _ImportDatabaseState extends State<ImportDatabase> {
  final RestaurantCampaignsBloc bloc = RestaurantCampaignsBloc(sl(), sl());
  final int id = SessionController().user?.restaurant.id ?? 0;
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Import/Export Database'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider<RestaurantCampaignsBloc>.value(
          value: bloc,
          child: BlocConsumer<RestaurantCampaignsBloc, RestaurantCampaignsState>(
            listener: (context, state) {
              if(state.importResponse.status == Status.error){
                context.flushBarErrorMessage(message: state.importResponse.message.toString());
              }
              if(state.importResponse.status == Status.completed){
                context.flushBarSuccessMessage(message: state.importResponse.data.toString());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  FilePickerWidget(
                    allowedExtensions: ['xlsx', 'xls', 'csv'],
                    onFileSelected: (file) {
                      setState(() {
                        selectedFile = file;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CsvDownloadButton(),
                  const Spacer(),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: "Import Data",
                    isLoading: state.importResponse.status == Status.loading,
                    onPressed: () {
                      if(selectedFile == null){
                        context.flushBarErrorMessage(message: "Pick a file to continue");
                        return;
                      }
                      bloc.add(ImportCSVFile(
                        ImportCSVFileParms(file: selectedFile!.path.toString(), restaurantId: id),
                      ));
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
