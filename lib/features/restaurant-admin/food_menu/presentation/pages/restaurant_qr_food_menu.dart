import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/presentation/download_qr_cubit/download_cubit.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/icon_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RestaurantQrFoodMenu extends StatelessWidget {
  final String menuUrl;

  const RestaurantQrFoodMenu({super.key, required this.menuUrl});

  @override
  Widget build(BuildContext context) {
    final screenshotController = ScreenshotController();

    return BlocProvider(
      create: (_) {
        final cubit = RestaurantQrCubit();
        cubit.init(screenshotController);
        return cubit;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Restaurant QR Food Menu'),
        backgroundColor: Colors.grey.shade50,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withSafeOpacity(.5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Food Menu QR Code',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Screenshot(
                  controller: screenshotController,
                  child: QrImageView(
                    backgroundColor: Colors.white,
                    data: menuUrl,
                    version: QrVersions.auto,
                    size: 250,
                    gapless: false,
                  ),
                ),
                const SizedBox(height: 24),
                BlocConsumer<RestaurantQrCubit, RestaurantQrState>(
                  listener: (context, state) {
                    if (state is RestaurantQrDownloaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("QR saved to gallery!")),
                      );
                    } else if (state is RestaurantQrError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is RestaurantQrDownloading;
                    return ButtonWithIcon(
                      icon: const Icon(Icons.download, color: Colors.white),
                      title: isLoading ? "Downloading..." : "Download",
                      onTap: isLoading
                          ? null
                          : () {
                              context
                                  .read<RestaurantQrCubit>()
                                  .downloadQr(menuUrl);
                            },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.grey),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "This QR code can be shared with anyone to access your restaurant's menu",
                        style: TextStyle(color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
