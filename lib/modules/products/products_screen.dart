// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesStates) {
          if (!state.model.status!) {
            showtoast(
              msg: state.model.message.toString(),
              states: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              builderWidget(cubit.homeModel, cubit.categoriesModel, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(
      HomeModel? model, CategoriesModel? categoriesModel, context) {
    if (model == null) {
      return Text(' Image Error ');
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 110.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesModel!.data!.data.length,
                    itemBuilder: (context, index) =>
                        buildCategorisitem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.62,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGridProduct(model.data!.products[index], context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategorisitem(DataModel model) => Column(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.1),
              radius: 25,
              backgroundImage: NetworkImage(
                model.image.toString(),
              ),
            ),
          ),
          SizedBox(height: 2.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black.withOpacity(0.55),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                model.name.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
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
              ],
            ),
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
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? Colors.red
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      
      );
}
