import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/item_model.dart';

class NavigationCubit extends Cubit<ItemModel?> {
  NavigationCubit() : super(null);

  void showPostDetails(ItemModel item) => emit(item);

  void popToPosts() => emit(null);
}
