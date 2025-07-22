part of 'profile_bloc.dart';

class ProfileState {
  final ApiResponse<String> response;
  final String profilePic;

  ProfileState({
    required this.response,
    this.profilePic = '',
  });

  ProfileState copyWith({
    ApiResponse<String>? response,
    String? profilePic,
  }) {
    return ProfileState(
      response: response ?? this.response,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
