import 'package:equatable/equatable.dart';

class InitializePaymentEntity extends Equatable {
  final String reference;
  final String authorizationUrl;
  final String accessCode;

  const InitializePaymentEntity({
    required this.reference,
    required this.authorizationUrl,
    required this.accessCode,
  });

  @override
  List<Object?> get props => [reference, authorizationUrl, accessCode];
}
