import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'download_state.dart';

class RestaurantQrCubit extends Cubit<RestaurantQrState> {
  RestaurantQrCubit() : super(RestaurantQrInitial());

  Future<void> downloadQr(String menuUrl) async {
    emit(RestaurantQrDownloading());

    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        emit(RestaurantQrError("Permission denied"));
        return;
      }

      // Generate QR image in memory
      final qrPainter = QrPainter(
        data: menuUrl,
        version: QrVersions.auto,
        gapless: false,
      );

      final uiImage = await qrPainter.toImage(500); // Higher = sharper
      final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List imageBytes = byteData!.buffer.asUint8List();

      // Save to gallery
      final result = await SaverGallery.saveImage(
        imageBytes,
        fileName: "restaurant_menu_qr.png",
        quality: 100,
        androidRelativePath: "Pictures/RestaurantQR",
        skipIfExists: false,
      );

      if (result.isSuccess) {
        emit(RestaurantQrDownloaded());
      } else {
        emit(RestaurantQrError(result.errorMessage ?? "Failed to save QR"));
      }
    } catch (e) {
      emit(RestaurantQrError(e.toString()));
    }
  }
}
