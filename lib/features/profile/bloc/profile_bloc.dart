import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/profile/bloc/profile_event.dart';
import 'package:secure_call/features/profile/bloc/profile_state.dart';
import 'package:secure_call/features/profile/utils/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {

    });
  }
}