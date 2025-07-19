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
