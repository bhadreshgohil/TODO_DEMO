import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/todo_products/bloc/todo_event.dart';
import 'package:todo_app/app/todo_products/bloc/todo_state.dart';
import 'package:todo_app/app/todo_products/repository/todo_products_repository.dart';

import '../data/response/todo_products_model.dart';




class TodoBloc extends Cubit<TodoState>{
  final ITodoProductsRepository? iTodoProductsRepository;
  TodoBloc({this.iTodoProductsRepository}):super(InitTodoState());


  List<GetProductModel> list = [];
  List<GetProductModel> mainList = [];




  Future getProductList()async{

    try {

      emit(LoadingTodoState());

      final response = await iTodoProductsRepository?.getProductList();
      mainList = response ?? [];
      emit(SuccessTodoState(list: response));

    } catch (e) {
      emit(ErrorTodoState(error: e.toString()));
      rethrow;
    }




  }








}