import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}
class FetchMenuEvent extends MenuEvent {
  final String id;

  const FetchMenuEvent(this.id);
}

class AddMenuEvent extends MenuEvent {
  final UploadMenuParms parms;

  const AddMenuEvent(this.parms);
}
