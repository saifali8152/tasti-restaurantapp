import '/features/restaurant-admin/gallery/domain/entities/gallery.dart';

class GalleryModel extends GalleryEntity {
  GalleryModel({
    required super.id,
    required super.name,
    required super.notes,
    required super.image,
    required super.type,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['ri_id'].toString(),
      name: json['name'],
      notes: json['notes'].toString(),
      image: json['path'].toString(),
      type: json['type'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ri_id': id,
      'name': name,
      'notes': notes,
      'path': image,
      'type': type,
    };
  }

  GalleryModel copyWith({
    String? id,
    String? name,
    String? notes,
    String? image,
    String? type,
  }) {
    return GalleryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      type: type ?? this.type,
    );
  }
}
