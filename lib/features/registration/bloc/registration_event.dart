import '../models/resend_code_model.dart';
import '../models/verify_model.dart';
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

class VerifyEvent extends RegistrationEvent {
  final VerifyModel model;

  VerifyEvent({required this.model});
}

class ResendCodeEvent extends RegistrationEvent {
  final ResendCodeModel model;

  ResendCodeEvent({required this.model});
}