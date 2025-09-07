import 'package:flutter/material.dart';

class DrawerItemModel {
  final IconData icon;
  final String title;
  final int? index;
  final bool isExpandable;
  final List<DrawerItemModel>? children;
  final String? permissionKey;

  DrawerItemModel({
    required this.icon,
    required this.title,
    this.index,
    this.isExpandable = false,
    this.children,
    this.permissionKey,
  });
}