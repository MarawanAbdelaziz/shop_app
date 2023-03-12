import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

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
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          // ignore: prefer_const_literals_to_create_immutables
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottom(value);
            },
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'categorys', icon: Icon(Icons.apps)),
              BottomNavigationBarItem(
                  label: 'favorites', icon: Icon(Icons.favorite)),
              BottomNavigationBarItem(
                  label: 'settings', icon: Icon(Icons.settings)),
            ],
          ),
        );
      },
    );
  }
}
