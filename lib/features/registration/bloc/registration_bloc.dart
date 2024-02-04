import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_event.dart';
import 'package:secure_call/features/registration/bloc/registration_state.dart';
import 'package:secure_call/features/registration/utils/registration_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc(this.registrationRepository) : super(RegistrationInitial()) {
    on<RegisterEvent>((event, emit) async {
      bool result = await registrationRepository.register(event.model);
      if (result) {
        emit(RegisterSuccess(message: 'Registration successful'));
      } else {
        emit(RegisterFailure(message: 'Registration failed'));
      }
    });

    on<LoginEvent>((event, emit) async {
      bool result = await registrationRepository.login(event.model);
      if (result) {
        emit(LoginSuccess(message: 'Login successful'));
      } else {
        emit(LoginFailure(message: 'Login failed'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await registrationRepository.logout();
      emit(RegistrationInitial());
    });
  }
}