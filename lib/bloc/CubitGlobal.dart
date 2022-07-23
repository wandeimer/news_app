import 'package:bloc/bloc.dart';

class CubitGlobal<T> extends Cubit<T> {

  CubitGlobal(T initialState) : super(initialState);

  void customEmit(T state){
    if(isClosed)
      return;
    emit(state);
  }

}