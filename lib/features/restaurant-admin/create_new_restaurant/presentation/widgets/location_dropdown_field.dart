import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_search_field.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_state.dart';
import '/core/network/response.dart';
import '/core/widgets/loading_widget.dart';

class LocationDropdownField extends StatefulWidget {
  final CreateNewRestaurantBloc bloc;
  final void Function(String)? onChanged;
  final String? initialValue;
  const LocationDropdownField({
    required this.bloc,
    super.key,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<LocationDropdownField> createState() => _LocationDropdownFieldState();
}

class _LocationDropdownFieldState extends State<LocationDropdownField> {
  late TextEditingController _mainController;
  Timer? _debounce;
  bool _sheetOpen = false;

  @override
  void initState() {
    _mainController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _mainController.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.bloc.add(LocationChanged(location: value));
    });

    if (value.isNotEmpty && !_sheetOpen) {
      _openSheet();
    } else if (value.isEmpty && _sheetOpen) {
      _closeSheet();
    }
  }

  void _openSheet() async {
    _sheetOpen = true;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _buildSheetContent(),
      ),
    );
    _sheetOpen = false;
  }

  void _closeSheet() {
    if (_sheetOpen) {
      Navigator.of(context).pop();
      _sheetOpen = false;
    }
  }

  Widget _buildSheetContent() {
    return BlocBuilder<CreateNewRestaurantBloc, CreateNewRestaurantState>(
      bloc: widget.bloc,
      builder: (context, state) {
        final suggestions = state.locationResponse.status == Status.completed
            ? state.locationResponse.data!
            : <dynamic>[];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomSearchField(
                hintText: 'Restaurant address',
                icon: Icons.map,
                radius: 12,
                controller: _mainController,
                onChanged: _onTextChanged,
              ),
            ),
            if (suggestions.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, i) {
                    final item = suggestions[i];
                    return ListTile(
                      title: Text(item.description),
                      onTap: () {
                        _mainController.text = item.description;
                        widget.bloc.add(SelectLocation(
                          locationSet: true,
                          selectedLocation: item,
                        ));
                        _closeSheet();
                        FocusScope.of(context).unfocus();
                      },
                    );
                  },
                ),
              )
            else if (state.locationResponse.status == Status.loading)
              LoadingWidget()
            else
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No matches found'),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewRestaurantBloc, CreateNewRestaurantState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return CustomSearchField(
          controller: _mainController,
          hintText: 'Search location',
          icon: Icons.map,
          radius: 12,
          onChanged: _onTextChanged,
        );
      },
    );
  }
}
