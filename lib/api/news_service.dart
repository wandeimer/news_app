import 'package:dio/dio.dart';
import 'package:news_app/common/const.dart';
import 'package:news_app/models/item_model.dart';

class NewsService {
  late Dio _dio;

  NewsService() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      headers: {"Authorization": apiAuthKey},
    );
    _dio = Dio(options);
  }

  Future<List<ItemModel>?> getNewsList(
    String? request,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    int page,
  ) async {
    Map<String, dynamic> query = {
      "page": page,
      "pageSize": 20,
    };
    if (request != null && request.isNotEmpty) {
      query.addAll({"q": request});
    } else {
      query.addAll({"q": "iOS"});
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      query.addAll({"sortBy": sortBy});
    }
    // todo
    // add date change logic
    List<ItemModel> _result = List<ItemModel>.empty(growable: true);
    try {
      var response = await _dio.get(apiEndpointUrl, queryParameters: query);
      if (response.statusCode == 200) {
        for (var item in response.data["articles"]) {
          _result.add(ItemModel.fromJson(item));
        }
        return _result;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {}
      return null;
    }
  }
}
