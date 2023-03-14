// ignore_for_file: avoid_print ,prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';
// ignore_for_file:prefer_const_constructors

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  required Function function,
  required String text,
  bool isUpperCase = true,
  double fontSize = 30.0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isPassword = false,
  bool isClickable = true,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  double topRightRadius = 20.0,
  double bottomLeftRadius = 20.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
        )),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

Widget buildArticlesItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',

                      // style: Theme.of(context).textTheme.bodyMedium,

                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (BuildContext context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) =>
            buildArticlesItem(list[index], context),
        separatorBuilder: (BuildContext context, int index) {
          return myDivider();
        },
      ),
      fallback: (BuildContext context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Future<bool?> showtoast({
  required String msg,
  Toast toastLength = Toast.LENGTH_LONG,
  ToastGravity gravity = ToastGravity.TOP,
  int timeInSecForIosWeb = 1,
  required ToastStates states,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: chooseToastColor(states),
      textColor: textColor,
      fontSize: fontSize,
    );

enum ToastStates { success, error, warinig }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warinig:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image.toString()),
                  height: 120.0,
                  width: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
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
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20.0),
            Expanded(
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
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
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
      ),
    );
