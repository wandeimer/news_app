part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  get data => null;
}

class SearchInitial extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {
  final String request;

  SearchLoading(this.request);
}

class SearchComplete extends SearchState {}

class SearchLoaded<T> extends SearchState {
  @override
  final List<ItemModel>? data;

  SearchLoaded(this.data);
}

class SearchLoadingMore<T> extends SearchState {
  @override
  final List<ItemModel>? data;
  final String request;

  SearchLoadingMore(this.data, this.request);
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
