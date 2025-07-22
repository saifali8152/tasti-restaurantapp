part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileImageChanged extends ProfileEvent {
  final ImageSource source;
  ProfileImageChanged({required this.source});
}

class SetProfilePic extends ProfileEvent {
  final String pic;
  SetProfilePic(this.pic);
}

class UpdateProfile extends ProfileEvent {
  final String name;

  UpdateProfile(this.name);
}
