class LoginParms {
  final String email;
  final String password;

  LoginParms({required this.email, required this.password});
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