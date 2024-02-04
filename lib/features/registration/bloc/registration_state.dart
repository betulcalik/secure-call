abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegisterSuccess extends RegistrationState {
  final String message;

  RegisterSuccess({required this.message});
}

class RegisterFailure extends RegistrationState {
  final String message;

  RegisterFailure({required this.message});
}

class LoginSuccess extends RegistrationState {
  final String message;

  LoginSuccess({required this.message});
}

class LoginFailure extends RegistrationState {
  final String message;

  LoginFailure({required this.message});
}