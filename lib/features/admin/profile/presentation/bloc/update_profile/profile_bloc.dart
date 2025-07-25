import 'dart:io';
import 'package:bloc/bloc.dart';
import '/features/admin/profile/domain/usecases/update_profile_usecase.dart';
import '/features/skaleton/user_cubit/skaleton_cubit.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '/core/services/picker_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PickerServices pickerServices;
  final UpdateProfileUseCase updateProfileUseCase;
  final SessionController sC;
  final UserCubit userCubit;

  ProfileBloc({
    required this.pickerServices,
    required this.updateProfileUseCase,
    required this.sC,
    required this.userCubit,
  }) : super(ProfileState(response: ApiResponse.initial())) {
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<SetProfilePic>(_onSetProfilePic);
    on<UpdateProfile>(_onUpdateProfile);
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {

    try {
      emit(state.copyWith(response: ApiResponse.loading()));

      if(event.name == sl<UserCubit>().state.user!.name && state.profilePic.contains("http")){
        return emit(state.copyWith(response: ApiResponse.completed("Profile updated successfully")));
      }

      UpdateProfileParms parms = UpdateProfileParms(profilePic: state.profilePic, name: event.name);

      final response = await updateProfileUseCase.call(parms);
      if (response.status == Status.completed) {
        await sC.saveUserSession(response.data!);
        await sC.loadSession();
        userCubit.setUser(response.data!);
        emit(state.copyWith(response: ApiResponse.completed("Profile updated successfully")));
      } else {
        emit(state.copyWith(
            response: ApiResponse.error(response.message.toString())));
      }
    } catch (e) {
      emit(state.copyWith(response: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onProfileImageChanged(
      ProfileImageChanged event, Emitter<ProfileState> emit) async {
    final File? path = await _pickFile(
      event.source,
    );
    if (path != null) {
      emit(state.copyWith(profilePic: path.path));
    }
  }

  Future<void> _onSetProfilePic(
      SetProfilePic event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(profilePic: event.pic));
  }

  Future<File?> _pickFile(
    ImageSource source,
  ) async {
    if (source == ImageSource.camera) {
      final XFile? image = await pickerServices.cameraImage();
      return File(image!.path);
    } else if (source == ImageSource.gallery) {
      final XFile? image = await pickerServices.galleryImage();
      return File(image!.path);
    }
    return null;
  }
}
