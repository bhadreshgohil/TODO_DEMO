import '../data/response/todo_products_model.dart';

abstract class TodoState {}
class InitTodoState extends TodoState{}
class LoadingTodoState extends TodoState{}
class LoadingCartTodoState extends TodoState{}
class ErrorTodoState extends TodoState{
  final String? error;
  ErrorTodoState({this.error});
}
class SuccessTodoState extends TodoState{
  final List<GetProductModel>? list;
  SuccessTodoState({this.list});
}
// class SuccessCartTodoState extends TodoState{
//   final List<GetProductModel>? list;
//   SuccessTodoState({this.list});
// }
