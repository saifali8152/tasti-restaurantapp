import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/core/widgets/loading_widget.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? heightPercent;
  final double borderRadius;
  final BoxFit boxFit;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.heightPercent,
    this.borderRadius = 10,
    this.boxFit = BoxFit.contain,
  });

  double _getImageHeight(BuildContext context) {
    if (height != null) return height!;
    if (heightPercent != null) {
      return MediaQuery.of(context).size.height * heightPercent!;
    }
    return 100;
  }

  bool _isAssetImage(String url) => url.startsWith('assets/');
  bool _isFileImage(String url) => url.startsWith('file:/') || File(url).existsSync();

  @override
  Widget build(BuildContext context) {
    final double imageHeight = _getImageHeight(context);

    Widget imageWidget;

    if (_isAssetImage(imageUrl)) {
      imageWidget = Image.asset(
        imageUrl,
        height: imageHeight,
        width: double.infinity,
        fit: boxFit,
      );
    } else if (_isFileImage(imageUrl)) {
      imageWidget = Image.file(
        File(imageUrl),
        height: imageHeight,
        width: double.infinity,
        fit: boxFit,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: imageHeight,
        fit: boxFit,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          width: double.infinity,
          height: imageHeight,
          fit: boxFit,
        ),
        placeholder: (context, url) => SizedBox(
          width: double.infinity,
          height: imageHeight,
          child: const Center(child: LoadingWidget()),
        ),
        errorWidget: (context, url, error) => _errorWidget(imageHeight),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }

  Widget _errorWidget(double height) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.error_outline,
        size: 25,
        color: Colors.redAccent,
      ),
    );
  }
}