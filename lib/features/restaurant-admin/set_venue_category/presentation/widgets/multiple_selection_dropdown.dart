import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String hintText;
  final List<String>? initialSelected;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select',
    this.initialSelected,
  });

  @override
  MultiSelectDropdownState createState() => MultiSelectDropdownState();
}

class MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> selectedItems;

  @override
  void didUpdateWidget(covariant MultiSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelected != oldWidget.initialSelected) {
      setState(() {
        selectedItems = widget.initialSelected ?? [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedItems = widget.initialSelected ?? [];
  }

  void _showMultiSelectDialog() async {
    final List<String> tempSelected = List.from(selectedItems);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(widget.hintText),
              content: SingleChildScrollView(
                child: Column(
                  children: widget.items.map((item) {
                    final isSelected = tempSelected.contains(item);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(item),
                      onChanged: (bool? checked) {
                        setDialogState(() {
                          if (checked == true) {
                            if (!tempSelected.contains(item)) {
                              tempSelected.add(item);
                            }
                          } else {
                            tempSelected.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('CANCEL',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomButton(
                  onPressed: () {
                    setState(() => selectedItems = tempSelected);
                    widget.onChanged(selectedItems.join(','));
                    Navigator.pop(context);
                  },
                  text: "Confirm",
                  isFullWidth: false,
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedItems.isEmpty
                    ? widget.hintText
                    : selectedItems.join(', '),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
