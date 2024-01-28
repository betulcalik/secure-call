import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class RegistrationEvent {}

class RegisterEvent extends RegistrationEvent {
  final RegisterModel model;

  RegisterEvent({required this.model});
}

class LoginEvent extends RegistrationEvent {
  final LoginModel model;

  LoginEvent({required this.model});
}

class LogoutEvent extends RegistrationEvent {}