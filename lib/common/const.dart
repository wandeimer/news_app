import 'package:intl/intl.dart';
import 'package:news_app/models/sort_by_item_model.dart';

const String apiBaseUrl = "https://newsapi.org/";
const String apiEndpointUrl = "v2/everything";
const String apiAuthKey = "3443efc84dc0489e9a1c42fcf8cb7360";
DateFormat dateFormat = DateFormat('yyyy-MM-dd');

const List<SortByItemModel> sortList = [
  SortByItemModel(name: "Newest", key: "publishedAt"),
  SortByItemModel(name: "Relevancy", key: "relevancy"),
  SortByItemModel(name: "Hot", key: "popularity"),
];
