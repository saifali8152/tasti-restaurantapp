import '/core/enum/query_type.dart';
import '/core/enum/request_type.dart';

class LoginParms {
  final String email;
  final String password;

  LoginParms({required this.email, required this.password});
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

  PaginationParms({
    this.page = '1',
    this.limit = '10',
    this.search = '',
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
