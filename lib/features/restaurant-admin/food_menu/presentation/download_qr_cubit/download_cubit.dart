import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';

part 'download_state.dart';
class RestaurantQrCubit extends Cubit<RestaurantQrState> {
  RestaurantQrCubit() : super(RestaurantQrInitial());

  late ScreenshotController _screenshotController;

  void init(ScreenshotController controller) {
    _screenshotController = controller;
  }

  Future<void> downloadQr(String menuUrl) async {
    emit(RestaurantQrDownloading());

    try {
      // 1. Ask for permissions (Android only)
      if (await Permission.storage.request().isDenied) {
        emit(RestaurantQrError("Storage permission denied"));
        return;
      }

      // 2. Capture the QR widget
      final Uint8List? imageBytes = await _screenshotController.capture(
        delay: const Duration(milliseconds: 200), // wait for render
      );

      if (imageBytes == null) {
        emit(RestaurantQrError("Failed to capture QR code"));
        return;
      }

      // 3. Save to gallery
      final result = await SaverGallery.saveImage(
        imageBytes,
        quality: 100,
        fileName: "restaurant_menu_qr",
        androidRelativePath: "Pictures/RestaurantQR",
        skipIfExists: false,
      );

      if (result.isSuccess) {
        emit(RestaurantQrDownloaded());
      } else {
        emit(RestaurantQrError("Failed to save QR code"));
      }
    } catch (e) {
      emit(RestaurantQrError(e.toString()));
    }
  }
}
