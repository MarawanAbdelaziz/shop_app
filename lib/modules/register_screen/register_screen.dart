// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPressed = true;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                const SizedBox(height: 30.0),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please don\'t let me empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: Icons.person,
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
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please don\'t let me empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone_android_outlined,
                ),
                const SizedBox(height: 40.0),
                defaultFormField(
                  controller: passwordController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please don\'t let me empty';
                    }
                    return null;
                  },
                  label: 'Password',
                  isPassword: isPressed,
                  prefix: Icons.key,
                  suffix: isPressed
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                ),
                const SizedBox(height: 50.0),
                Center(
                  child: defaultButton(
                    function: () {},
                    text: 'Register',
                    background: Colors.black,
                    radius: 20.0,
                    width: 230.0,
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
