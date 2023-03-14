import 'package:shop_app/models/login_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLodaingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends RegisterState {}
