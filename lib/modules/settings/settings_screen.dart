// ignore_for_file: prefer_const_constructors
// ignore_for_file:  prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/network/dio_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataStates) {}
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        var model = cubit.userModel!;
        nameController.text = model.data!.name.toString();
        emailController.text = model.data!.email.toString();
        phoneController.text = model.data!.phone.toString();

        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserStates)
                          LinearProgressIndicator(),
                        SizedBox(height: 20.0),

                        //* Name Form Field
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Plese Don\'t let me empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),

                        SizedBox(height: 20.0),

                        //* Email Address Form Field
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Plese Don\'t let me empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),

                        SizedBox(height: 20.0),

                        //* Phone  Form Field
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Plese Don\'t let me empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone_android,
                        ),

                        SizedBox(height: 40.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultButton(
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.updateUsderData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Update',
                                radius: 20.0,
                                width: 100.0,
                                fontSize: 15.0),
                            SizedBox(width: 40.0),
                            defaultButton(
                                function: () {
                                  signOut(context);
                                },
                                text: 'Signout',
                                radius: 20.0,
                                width: 100.0,
                                fontSize: 15.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            fallback: (context) => CircularProgressIndicator());
      },
    );
  }
}
