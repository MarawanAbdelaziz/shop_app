// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/network/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLodaingState());
    DioHelper.postData(
      url: loginUrl,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
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
