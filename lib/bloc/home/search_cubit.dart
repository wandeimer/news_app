import 'package:meta/meta.dart';
import 'package:news_app/api/news_service.dart';
import 'package:news_app/bloc/CubitGlobal.dart';
import 'package:news_app/models/item_model.dart';

part 'search_state.dart';

class SearchCubit extends CubitGlobal<SearchState> {
  final NewsService newsService;
  int _page = 1;
  bool _allPagesLoaded = false;
  String _request = "";
  DateTime? _startDate;
  DateTime? _endDate;
  String? _sortBy;
  List<ItemModel> _newsList = List<ItemModel>.empty(growable: true);

  SearchCubit(this.newsService) : super(SearchInitial());

  void empty() {
    customEmit(SearchEmpty());
  }

  void searchNews({
    String? request,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
  }) async {
    _page = 1;
    _allPagesLoaded = false;
    _request = request ?? "";
    _startDate = startDate;
    _endDate = endDate;
    _sortBy = sortBy;
    customEmit(SearchLoading(_request));

    try {
      final values = await Future.wait([
        newsService.getNewsList(_request, _startDate, _endDate, _sortBy, _page),
      ]);

      List<ItemModel>? newsList = values[0];
      if ((newsList ?? []).isEmpty) {
        _allPagesLoaded = true;
      }

      if (state is SearchLoading) {
        if ((state as SearchLoading).request == (request ?? "")) {
          _newsList = newsList ?? [];
          customEmit(SearchLoaded<List<ItemModel>?>(newsList));
        }
      }
      return;
    } catch (e) {
      customEmit(SearchError(message: e.toString()));
    }
  }
}
