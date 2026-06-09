import '/core/models/pagination.dart';

import '/core/utils/json_parsers.dart';

import '/features/admin/manage_sms/domain/entities/admin_sms.dart';



class AdminSmsModel extends AdminSmsEntity {

  const AdminSmsModel({

    required List<AdminsmsItemModel> super.data,

    required super.pagination,

  });



  factory AdminSmsModel.fromJson(Map<String, dynamic> json) {

    return AdminSmsModel(

      data: List<AdminsmsItemModel>.from(

        (json['data'] as List<dynamic>? ?? [])

            .map((item) => AdminsmsItemModel.fromJson(item)),

      ),

      pagination: PaginationModel.fromJson(

        json['pagination'] as Map<String, dynamic>? ?? {},

      ),

    );

  }



  Map<String, dynamic> toJson() {

    return {

      'data': data.map((e) => (e as AdminsmsItemModel).toJson()).toList(),

      'pagination': pagination.toJson(),

    };

  }

}



class AdminsmsItemModel extends AdminSmsItem {

  const AdminsmsItemModel({

    required super.id,

    required super.productOwner,

    required super.discount,

    required super.percentage,

    required super.bundles,

    required super.amount,

    required super.hasDiscount,

  });



  factory AdminsmsItemModel.fromJson(Map<String, dynamic> json) {

    return AdminsmsItemModel(

      id: parseJsonInt(json['id']),

      productOwner: parseJsonString(json['product_owner']),

      discount: parseJsonString(json['discount']),

      percentage: parseJsonString(json['percentage']),

      bundles: parseJsonString(json['bundles']),

      amount: parseJsonString(json['amount']),

      hasDiscount: parseJsonBool(json['has_discount']),

    );

  }



  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'product_owner': productOwner,

      'discount': discount,

      'percentage': percentage,

      'bundles': bundles,

      'amount': amount,

      'has_discount': hasDiscount,

    };

  }



  @override

  List<Object?> get props => [

        id,

        productOwner,

        discount,

        percentage,

        bundles,

        amount,

        hasDiscount,

      ];

}

