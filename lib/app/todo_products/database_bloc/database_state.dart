import '../data/response/todo_products_model.dart';

abstract class DatabaseState {}
class InitTodoState extends DatabaseState{}
class LoadingTodoState extends DatabaseState{}
class LoadingCartTodoState extends DatabaseState{}
class ErrorTodoState extends DatabaseState{
  final String? error;
  ErrorTodoState({this.error});
}
class CreateCartState extends DatabaseState{

}
class SuccessTodoState extends DatabaseState{
  final List<GetProductModel>? list;
  SuccessTodoState({this.list});
}