import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/utils/general_extentions.dart';

class PaxTile extends StatefulWidget {
  final TableCapacityData data;
  const PaxTile({super.key, required this.data});

  @override
  State<PaxTile> createState() => _PaxTileState();
}

class _PaxTileState extends State<PaxTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          CheckboxListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            checkColor: AppColors.darkOrange,
            tileColor: AppColors.lightOrange.withSafeOpacity(.28),
            value: widget.data.isSelected,
            title: Row(
              children: [
                Text("Table Capacity "),
                SizedBox(width: 10),
                Text(
                  "${widget.data.pax} PAX",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            side: BorderSide.none,
            onChanged: (val) {
              setState(() {
                widget.data.isSelected = val ?? false;
              });
            },
          ),
          if (widget.data.isSelected)
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallNumberField(
                              "Min Capacity",
                              widget.data.minCapacityController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildSmallNumberField(
                              "Number of Tables",
                              widget.data.numberOfTablesController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: "Type"),
                        items: const [
                          DropdownMenuItem(value: "High", child: Text("High")),
                          DropdownMenuItem(value: "Low", child: Text("Low")),
                        ],
                        initialValue: widget.data.type,
                        onChanged: (val) {
                          setState(() {
                            widget.data.type = val;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: "Shape"),
                        items: const [
                          DropdownMenuItem(
                              value: "Square/Rectangle",
                              child: Text("Square/Rectangle")),
                          DropdownMenuItem(
                              value: "Round", child: Text("Round")),
                        ],
                        initialValue: widget.data.shape,
                        onChanged: (val) {
                          setState(() {
                            widget.data.shape = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  value: widget.data.isMoveable,
                  title: const Text("Moveable"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (val) {
                    setState(() {
                      widget.data.isMoveable = val ?? false;
                    });
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSmallNumberField(
      String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

class TableCapacityData {
  final int pax;
  bool isSelected = false;
  final TextEditingController minCapacityController = TextEditingController();
  final TextEditingController numberOfTablesController =
      TextEditingController();
  bool isMoveable = false;
  String? type;
  String? shape;

  TableCapacityData({required this.pax});
}
