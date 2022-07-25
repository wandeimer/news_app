import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/news_service.dart';
import 'package:news_app/common/const.dart';
import 'package:news_app/models/item_model.dart';
import 'package:news_app/models/sort_by_item_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final NewsService newsService;
  int _page = 1;
  bool allPagesLoaded = false;
  String _request = "";
  DateTime startDate = DateTime.now().toUtc();
  DateTime endDate = DateTime.now().toUtc();
  SortByItemModel sortBy = sortList[0];
  List<ItemModel> _newsList = List<ItemModel>.empty(growable: true);

  SearchCubit(this.newsService) : super(SearchInitial());

  void empty() {
    emit(SearchEmpty());
  }

  void changeSort(SortByItemModel sort) {
    sortBy = sort;
    searchNews(request: _request);
  }

  void changeStartDate(BuildContext context) async {
    DateTime? res = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (res != null) {
      startDate = res.toUtc();
      searchNews(request: _request);
    }
  }

  void changeEndDate(BuildContext context) async {
    DateTime? res = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (res != null) {
      endDate = res.toUtc();
      searchNews(request: _request);
    }
  }

  void searchNews({
    String? request,
  }) async {
    _page = 1;
    allPagesLoaded = false;
    _request = request ?? "";
    emit(SearchLoading(_request));

    try {
      final values = await Future.wait([
        newsService.getNewsList(
          _request,
          dateFormat.format(startDate),
          dateFormat.format(endDate),
          sortBy.key,
          _page,
        ),
      ]);

      List<ItemModel>? newsList = values[0];
      if ((newsList ?? []).isEmpty) {
        allPagesLoaded = true;
      }

      if (state is SearchLoading) {
        if ((state as SearchLoading).request == (request ?? "")) {
          _newsList = newsList ?? [];
          emit(SearchLoaded<List<ItemModel>?>(newsList));
        }
      }
      return;
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  void loadMoreNews() async {
    if (state is SearchLoaded) {
      _page += 1;
      emit(SearchLoadingMore(_newsList, _request));

      try {
        List<ItemModel>? newsList = await newsService.getNewsList(
          _request,
          dateFormat.format(startDate),
          dateFormat.format(endDate),
          sortBy.key,
          _page,
        );

        if ((newsList ?? []).isEmpty) {
          allPagesLoaded = true;
        }

        if (state is SearchLoadingMore) {
          if ((state as SearchLoadingMore).request == (_request)) {
            _newsList.addAll(newsList ?? []);
            emit(SearchLoaded(_newsList));
          }
        }
        return;
      } catch (e) {
        emit(SearchError(message: e.toString()));
      }
    }
    return;
  }
}
