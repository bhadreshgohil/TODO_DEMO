import 'dart:convert';
import 'dart:developer';

import '../../../usecases/todo_use_cases.dart';
import '../data/response/todo_cart_model.dart';
import '../data/response/todo_products_model.dart';

abstract class ITodoProductsRepository{
  Future<List<GetProductModel>> getProductList();
}

class TodoProductsRepository extends ITodoProductsRepository{

  final ITodoUseCase todoUseCase;

  TodoProductsRepository({required this.todoUseCase});

  @override
  Future<List<GetProductModel>> getProductList() async{
    final response  = await todoUseCase.getTodoProductListData();
     return getAsOfDateModelFromJson(jsonEncode(response));
  }









}