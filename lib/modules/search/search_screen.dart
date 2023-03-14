// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onSubmit: (value) {
                      cubit.search(searchController.text);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Pleas don\'t let me empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                  const SizedBox(height: 10.0),
                  if (state is SearchLoadingStates)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccsessStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                          cubit.searchModel!.data!.data![index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.searchModel!.data!.data!.length,
                      ),
                    ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
