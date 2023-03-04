import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // ignore: unused_local_variable
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Btaaats'),
            centerTitle: true,
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          // ignore: prefer_const_literals_to_create_immutables
          bottomNavigationBar: BottomNavigationBar(items: [
            const BottomNavigationBarItem(icon: Icon(Icons.category)),
            const BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          ]),
        );
      },
    );
  }
}
