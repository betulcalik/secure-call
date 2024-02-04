abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegisterSuccess extends RegistrationState { }

class RegisterFailure extends RegistrationState {
  final String message;

  RegisterFailure({required this.message});
}

class LoginSuccess extends RegistrationState { }

class LoginFailure extends RegistrationState {
  final String message;

  LoginFailure({required this.message});
}

class VerifySuccess extends RegistrationState { }

class VerifyFailure extends RegistrationState {
  final String message;

  VerifyFailure({required this.message});
}

class ResendCodeSuccess extends RegistrationState { }

class ResendCodeFailure extends RegistrationState {
  final String message;

  ResendCodeFailure({required this.message});
}