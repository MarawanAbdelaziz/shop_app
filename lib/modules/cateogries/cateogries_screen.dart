import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.categoriesModel!.data!.data.length,
          separatorBuilder: (BuildContext context, int index) => myDivider(),
          itemBuilder: (BuildContext context, int index) =>
              buildWidget(cubit.categoriesModel!.data!.data[index]),
        );
      },
    );
  }

  Widget buildWidget(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.1),
              radius: 50,
              child: Image(
                image: NetworkImage(model.image.toString()),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              model.name.toString(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
