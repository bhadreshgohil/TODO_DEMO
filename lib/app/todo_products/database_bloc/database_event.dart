import '../data/response/todo_products_model.dart';

abstract class DatabaseEvent {}

class CreateCartEvent extends DatabaseEvent{
  final GetProductModel? getProductModel;
  CreateCartEvent({this.getProductModel});
}