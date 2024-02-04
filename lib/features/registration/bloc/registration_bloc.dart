import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_event.dart';
import 'package:secure_call/features/registration/bloc/registration_state.dart';
import 'package:secure_call/features/registration/utils/registration_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc(this.registrationRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>((event, emit) async {
      Map<String, dynamic> result = await registrationRepository.register(event.model);
      if (result["success"]) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(message: result["message"]));
      }
    });

    on<LoginEvent>((event, emit) async {
      Map<String, dynamic> result = await registrationRepository.login(event.model);
      if (result["success"]) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: result["message"]));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await registrationRepository.logout();
      emit(RegistrationInitial());
    });

    on<VerifyEvent>((event, emit) async {
      Map<String, dynamic> result = await registrationRepository.verify(event.model);
      if (result["success"]) {
        emit(VerifySuccess());
      } else {
        emit(VerifyFailure(message: result["message"]));
      }
    });
  }
}