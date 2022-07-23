part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {
  final String request;

  SearchLoading(this.request);
}

class SearchComplete extends SearchState {}

class SearchLoaded<T> extends SearchState {
  final T data;

  SearchLoaded(this.data);
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
