abstract class AdminDeleteSmsEvent {}

class AdminDeleteSmsRequested extends AdminDeleteSmsEvent {
  final String id;

  AdminDeleteSmsRequested(this.id); 
}
