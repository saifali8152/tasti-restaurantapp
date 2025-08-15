import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';

extension FlushBarErrorMessage on BuildContext {
  void flushBarErrorMessage({required String message}) {
    showFlushbar(
      context: this,
      flushbar: Flushbar(
        backgroundColor: const Color(0xFFFFE8E5), // soft coral
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(4),
        icon: const Icon(Icons.error_outline,
            color: Color(0xFFB91C1C), size: 24), // deep brick red
        messageText: Text(
          message,
          style: TextStyle(
            color: Color(0xFFB91C1C),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withSafeOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        animationDuration: const Duration(milliseconds: 550),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
      )..show(this),
    );
  }
}

extension FlushBarSuccessMessage on BuildContext {
  void flushBarSuccessMessage({required String message}) {
    showFlushbar(
      context: this,
      flushbar: Flushbar(
        backgroundColor: const Color(0xFFE6F6EE), // mint green
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        borderRadius: BorderRadius.circular(4),
        icon: const Icon(Icons.check_circle_outline,
            color: Color(0xFF047857), size: 28), // deep teal
        messageText: Text(
          message,
          style: TextStyle(
            color: Color(0xFF047857),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black.withSafeOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        animationDuration: const Duration(milliseconds: 550),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
      )..show(this),
    );
  }
}
