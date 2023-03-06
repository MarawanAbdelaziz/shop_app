// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) => builderWidget(cubit.homeModel),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel? model) {
    if (model == null) {
      return Text(' Image Error ');
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            // ignore: prefer_const_literals_to_create_immutables
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Error.svg/497px-Error.svg.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.59,
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridProduct(model.data!.products[index]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image.toString()),
                height: 200.0,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                    width: 90.0,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.red,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )),
            ]),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
