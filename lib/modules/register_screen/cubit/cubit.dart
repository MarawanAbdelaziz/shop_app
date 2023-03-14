// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/network/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLodaingState());

    DioHelper.postData(
      url: registerUrl,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    isPassword
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}
