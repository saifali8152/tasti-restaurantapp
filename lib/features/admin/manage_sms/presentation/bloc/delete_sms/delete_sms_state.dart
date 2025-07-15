abstract class AdminDeleteSmsState {}

class AdminDeleteSmsInitial extends AdminDeleteSmsState {}

class AdminDeleteSmsLoading extends AdminDeleteSmsState {}

class AdminDeleteSmsSuccess extends AdminDeleteSmsState {}

class AdminDeleteSmsError extends AdminDeleteSmsState {
  final String message;

  AdminDeleteSmsError(this.message);
}
