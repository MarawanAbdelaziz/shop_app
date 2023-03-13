// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? isDark = CacheHelper.getdata(key: "isDark");
  bool? onBoarding = CacheHelper.getdata(key: "onBoarding");
  token = CacheHelper.getdata(key: "token");
  print(token);

  if (onBoarding != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isDark ?? false, widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUsderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: darkTheme,
        // themeMode:
        //     NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

        home: startWidget,
      ),
    );
  }
}
