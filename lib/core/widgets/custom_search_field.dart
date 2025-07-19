import 'dart:async';

import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';

class CustomSearchField extends StatefulWidget {
  final String hintText;
  final void Function()? onTap;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final bool readOnly;
  final bool isEmailField;
  final TextEditingController? controller;
  final TextInputType keyboardInputType;
  final int maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsets padding;
  final TextStyle? hintStyle;
  final String? initialValue;
  final EdgeInsets contentPadding;
  final double radius;
  final bool enableValidation;

  const CustomSearchField({
    this.hintText = '',
    this.onTap,
    this.icon,
    this.isEmailField = false,
    this.enableValidation = true,
    this.readOnly = false,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPasswordField = false,
    this.controller,
    this.keyboardInputType = TextInputType.text,
    this.maxLines = 1,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.hintStyle,
    this.initialValue,
    this.contentPadding = const EdgeInsets.symmetric(
        horizontal: AppSpaces.screenHpad, vertical: 5),
    this.radius = 16,
    super.key,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  Timer? _debounce;

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length > 2 || value.isEmpty) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 400), () {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
    return Padding(
      padding: widget.padding,
      child: ValueListenableBuilder(
        valueListenable: obscureText,
        builder: (context, value, child) {
          return TextFormField(
            initialValue: widget.initialValue,
            onFieldSubmitted: widget.onFieldSubmitted,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            onChanged: _onChanged,
            maxLines: widget.maxLines,
            style: const TextStyle(fontWeight: FontWeight.normal),
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            obscureText: widget.isPasswordField ? obscureText.value : false,
            keyboardType: widget.keyboardInputType,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIconColor: Colors.black,
              contentPadding:
                  widget.icon == null ? widget.contentPadding : EdgeInsets.zero,
              prefixIcon: widget.icon == null ? null : Icon(widget.icon),
              suffixIcon: widget.suffixIcon ??
                  (widget.isPasswordField
                      ? IconButton(
                          onPressed: () {
                            obscureText.value = !obscureText.value;
                          },
                          icon: Icon(
                            obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ))
                      : null),
              hintText: widget.hintText.isEmpty ? null : widget.hintText,
              hintStyle:
                  widget.hintStyle ?? TextStyle(color: Colors.grey.shade600),
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
            ),
            validator: widget.enableValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "Field can't be empty!";
                    }
                    return null;
                  }
                : null,
          );
        },
      ),
    );
  }
}
