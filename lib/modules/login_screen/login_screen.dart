// ignore_for_file: must_be_immutable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showtoast(
                msg: state.loginModel.message.toString(),
                states: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Center(
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: Text(
                          'login mow to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please don\'t let me empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height: 40.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.text,
                        suffix: cubit.suffix,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.loginUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        isPassword: cubit.isPassword,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please don\'t let me empty';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.key_outlined,
                      ),
                      const SizedBox(height: 50.0),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! LoginLodaingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                            background: Colors.black,
                            radius: 20.0,
                            width: 230.0,
                          ),
                          fallback: (context) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        children: [
                          Text(
                            ' don\'t have account ?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              'Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: defaultColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
