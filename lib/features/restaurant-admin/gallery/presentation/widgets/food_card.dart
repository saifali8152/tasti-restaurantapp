import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/image_widget.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/entities/gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/widgets/delete_gallery_dialog.dart';

class FoodCard extends StatelessWidget {
  final GalleryEntity gallery;

  const FoodCard({
    super.key,
    required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ImageWidget(
                    imageUrl: gallery.image,
                    boxFit: BoxFit.cover,
                    borderRadius: 0,
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    gallery.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: (){
                      context.showCustomDialog(DeleteGalleryDialog(id: gallery.id));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Text(
              gallery.notes,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
