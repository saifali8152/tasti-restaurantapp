import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';

import '/core/enum/query_type.dart';
import '/core/enum/request_type.dart';

class TableData {
  final int maxCapacity;
  final int minCapacity;
  final int tableMax;
  final bool isMoveable;
  final String type;
  final String shape;

  TableData({
    required this.maxCapacity,
    required this.minCapacity,
    required this.tableMax,
    required this.isMoveable,
    required this.type,
    required this.shape,
  });

  Map<String, dynamic> toJson() {
    return {
      "max_capacity": maxCapacity,
      "min_capacity": minCapacity,
      "table_max": tableMax,
      "is_moveable": isMoveable,
      "type": type,
      "shape": shape,
    };
  }
}

class SeatingAreaParms {
  final int? id;
  final int restaurantId;
  final String seatingAreaName;
  final String abbreviation;
  final List<TableData> tables;

  SeatingAreaParms({
    this.id,
    required this.restaurantId,
    required this.seatingAreaName,
    required this.abbreviation,
    List<TableData>? tables,
  }) : tables = tables ?? [];

  /// Factory constructor to build from an entity
  factory SeatingAreaParms.fromEntity({
    required SeatingAreaEntity entity,
    required int restaurantId,
  }) {
    return SeatingAreaParms(
      id: entity.id,
      restaurantId: restaurantId,
      seatingAreaName: entity.seatingAreaName,
      abbreviation: entity.abbreviation,
      tables: entity.tables.map((t) {
        return TableData(
          maxCapacity: t.maxCapacity,
          minCapacity: t.minCapacity,
          tableMax: t.tableMax,
          isMoveable: t.isMoveable == 1,
          type: t.type,
          shape: t.shape,
        );
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "restaurant_id": restaurantId,
      "seating_area_name": seatingAreaName,
      "abbreviation": abbreviation,
      "tables": tables.map((t) => t.toJson()).toList(),
    };
  }
}


class GetPlaceDetailsParms {
  final String placeId;

  GetPlaceDetailsParms({required this.placeId});
}

class GetPlacePredictionParms {
  final String query;
  GetPlacePredictionParms({required this.query});
}

class LoginParms {
  final String email;
  final String password;

  LoginParms({required this.email, required this.password});
}

class CreateRestaurantParms {
  final String name;
  final String email;
  final String phone;
  final String website;
  final String address;
  final String city;
  final String lat;
  final String lon;
  final String dressCode;
  final String minimumSpend;
  final String description;
  final String cuisines;
  final String image;

  CreateRestaurantParms({
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.city,
    required this.lat,
    required this.lon,
    required this.dressCode,
    required this.minimumSpend,
    required this.description,
    required this.cuisines,
    required this.image,
  });
}

class UpdateRestaurantParms {
  final String name;
  final String email;
  final String phone;
  final String website;
  final String address;
  final String city;
  final String lat;
  final String lon;
  final String dressCode;
  final String minimumSpend;
  final String description;
  final String cuisines;
  final String image;
  final String cost;

  UpdateRestaurantParms({
    required this.cost,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.city,
    required this.lat,
    required this.lon,
    required this.dressCode,
    required this.minimumSpend,
    required this.description,
    required this.cuisines,
    required this.image,
  });
}

class SignupParms {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  SignupParms({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class UpdateMonthlyFeeParms {
  final String id;
  final String money;

  UpdateMonthlyFeeParms({required this.id, required this.money});
}

class UpdateProfileParms {
  final String name;
  final String profilePic;

  UpdateProfileParms({
    required this.name,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_pic': profilePic,
    };
  }
}

class ChangePasswordParms {
  final String currentPassword;
  final String newPassword;

  ChangePasswordParms({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}

class ReplyQueryParms {
  final int id;
  final String message;

  ReplyQueryParms({required this.id, required this.message});
}

class AddVenueParms {
  final int id;
  final String names;

  AddVenueParms({required this.id, required this.names});
}

class AddWorkingHourParms {
  final int id;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  AddWorkingHourParms({
    required this.id,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });
}

class UpdateWorkingHourParms {
  final int id;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  UpdateWorkingHourParms({
    required this.id,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });
}

class UploadMenuParms {
  final String id;
  final String menuFile;

  UploadMenuParms({
    required this.id,
    required this.menuFile,
  });
}

class AddCuisineParms {
  final int id;
  final String name;
  final String type;

  AddCuisineParms({required this.id, required this.name, required this.type});
}

class AddGalleryParms {
  final int id;
  final String name;
  final String notes;
  final String image;

  AddGalleryParms({
    required this.id,
    required this.name,
    required this.notes,
    required this.image,
  });
}

class VerifyUnverifyReviewParms {
  final int id;
  final String reviewId;

  VerifyUnverifyReviewParms({
    required this.id,
    required this.reviewId,
  });
}

class ActivateDeactivateTimeParms {
  final int id;
  final int timeId;

  ActivateDeactivateTimeParms({
    required this.id,
    required this.timeId,
  });
}

class UpdateDurationParms {
  final int id;
  final String timeDuration;

  UpdateDurationParms({
    required this.id,
    required this.timeDuration,
  });
}

class AddEventParms {
  final String title;
  final String link;
  final String image;

  AddEventParms({
    required this.title,
    required this.link,
    required this.image,
  });
}

class UpdateEventParms {
  final String eventId;
  final String title;
  final String link;
  final String image;

  UpdateEventParms({
    required this.eventId,
    required this.title,
    required this.link,
    required this.image,
  });
}

class PaginationParms {
  final String page;
  final String limit;
  final String search;
  final String id;

  PaginationParms({
    this.page = '1',
    this.limit = '10',
    this.search = '',
    this.id = '',
  });
}

class AllRestaurantParms {
  final String page;
  final String limit;
  final String search;
  final String filter;

  AllRestaurantParms({
    this.page = '1',
    this.limit = '10',
    this.search = '',
    this.filter = '',
  });
}

class RequestParms {
  final String page;
  final String limit;
  final String search;
  final RequestType type;

  RequestParms({
    this.page = '1',
    this.limit = '10',
    this.search = '',
    required this.type,
  });
}

class QueryParms {
  final String page;
  final String limit;
  final String search;
  final QueryType type;

  QueryParms({
    this.page = '1',
    this.limit = '10',
    this.search = '',
    required this.type,
  });
}

class AddSMSBundleParms {
  final String owner;
  final int quantity;
  final double discount;
  final int price;
  final int percentage;

  AddSMSBundleParms({
    required this.owner,
    required this.quantity,
    required this.discount,
    required this.price,
    required this.percentage,
  });
}

class ManageSmsBundleDiscountParms {
  final int id;
  final int discount;
  final int percentage;

  ManageSmsBundleDiscountParms({
    required this.id,
    required this.discount,
    required this.percentage,
  });
}
