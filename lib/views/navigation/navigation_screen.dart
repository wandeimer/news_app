import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/navigation/navigation_cubit.dart';
import 'package:news_app/models/item_model.dart';
import 'package:news_app/views/detail/detail_screen.dart';
import 'package:news_app/views/home/home_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, ItemModel?>(builder: ((context, item) {
      return Navigator(
        pages: [
          const MaterialPage(child: HomeScreen()),
          if (item != null) MaterialPage(child: DetailScreen(data: item))
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NavigationCubit>(context).popToPosts();
          return route.didPop(result);
        },
      );
    }));
  }
}
