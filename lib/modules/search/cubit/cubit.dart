// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text) {
    emit(SearchLoadingStates());

    DioHelper.postData(
      url: searchUrl,
      data: {'text': text},
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel);
      emit(SearchSuccsessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
