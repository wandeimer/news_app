import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/news_service.dart';
import 'package:news_app/bloc/home/search_cubit.dart';
import 'package:news_app/bloc/navigation/navigation_cubit.dart';
import 'package:news_app/views/home/home_screen.dart';
import 'package:news_app/views/navigation/navigation_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => NavigationCubit()),
      BlocProvider<SearchCubit>(create: (_) => SearchCubit(NewsService())..searchNews())
    ],
    child: const MaterialApp(
      home: NavigationScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
