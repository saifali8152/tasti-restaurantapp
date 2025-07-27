import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/initialize_payment.dart';

class InitializePaymentModel extends InitializePaymentEntity {
  const InitializePaymentModel({
    required super.reference,
    required super.authorizationUrl,
    required super.accessCode,
  });

  factory InitializePaymentModel.fromJson(Map<String, dynamic> json) {
    return InitializePaymentModel(
      reference: json['reference'].toString(),
      authorizationUrl: json['authorization_url'].toString(),
      accessCode: json['access_code'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'authorization_url': authorizationUrl,
      'access_code': accessCode,
    };
  }

  @override
  List<Object?> get props => [reference, authorizationUrl, accessCode];
}
