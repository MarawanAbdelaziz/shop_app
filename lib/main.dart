// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getboolean(key: "isDark");

  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      //!!!!!!
      darkTheme: darkTheme,

      // themeMode:
      //     NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

      home: OnBoardingScreen(),
    );
  }
}
