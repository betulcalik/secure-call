abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess({required this.message});
}

class RegistrationFailure extends RegistrationState {
  final String message;

  RegistrationFailure({required this.message});
}