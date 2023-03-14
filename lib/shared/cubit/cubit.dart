// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/network/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
      url: homeUrl,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image.toString());
      // print(homeModel!.status);

      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id: element.inFavorites});
      }

      // print(favorites.toString());

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: getCategoriesUrl,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesStates());

    DioHelper.postData(
      url: favoritesUrl,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(
      url: favoritesUrl,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

  LoginModel? userModel;

  void getUsderData() {
    emit(ShopLoadingUserDataStates());

    DioHelper.getData(
      url: profileUrl,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //   printFullText(userModel!.data!.name.toString());

      emit(ShopSuccessUserDataStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates());
    });
  }

  void updateUsderData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserStates());

    DioHelper.putData(
      url: updateProfileUrl,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      emit(ShopSuccessUpdateUserStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserStates());
    });
  }
}
