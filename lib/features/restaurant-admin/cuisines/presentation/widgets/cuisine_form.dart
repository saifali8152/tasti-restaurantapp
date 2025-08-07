import 'package:flutter/widgets.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/header_cell.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/widgets/delete_cuisine_dialog.dart';

class CuisineForm extends StatelessWidget {
  final List<CuisineEntity> cuisine;
  final String type;
  const CuisineForm({
    super.key,
    required this.cuisine,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final data = cuisine.where((cuisine)=> cuisine.type.toLowerCase() == type).toList();

    if(data.isEmpty){
      return SizedBox.shrink();
    } return Column(
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.only(
            top: 5,
                right: 10,
                bottom: 5,
                left: 10,
          ),
          decoration: const BoxDecoration(
            color: AppColors.tileHeader,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: const [
              HeaderCell('Name'),
              Spacer(),
              HeaderCell('Actions'),
            ],
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (_, i) {
            
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(
                top: 5,
                right: 10,
                bottom: 5,
                left: 10,
              ),
              color: AppColors.background,
              child: Row(
                children: [
                  Center(
                    child: Text(
                      data[i].name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomButton(
                        onPressed: () {
                          context.showCustomDialog(DeleteCuisineDialog(
                            id: data[i].typeId,
                          ));
                        },
                        text: "Delete",
                        isFullWidth: false,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
