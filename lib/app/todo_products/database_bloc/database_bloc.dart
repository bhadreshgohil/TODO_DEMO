import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_event.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_state.dart';

import '../database/sqlite_database.dart';
import '../repository/sqlite_repository.dart';

class DatabaseBloc extends Cubit<DatabaseState>{
  final ISqLiteRepository? databaseRepository;

  DatabaseBloc({this.databaseRepository}):super(InitTodoState());


  Future createCart(CreateCartEvent dataBaseEvent)async{

    if(dataBaseEvent.getProductModel == null) return;

    emit(LoadingTodoState());

    try {
     await databaseRepository?.createData(dataModel: dataBaseEvent.getProductModel!);
      emit(CreateCartState());
    } catch (e) {
      print("ERROR IS $e");
      emit(ErrorTodoState(error: e.toString()));
      rethrow;
    }

  }

  Future getCartData()async{

    emit(LoadingTodoState());

    try {
      final data = await databaseRepository?.getUserDetail();
      print("data:$data");
      emit(SuccessTodoState(list: data));
    } catch (e) {
      emit(ErrorTodoState(error: e.toString()));
      rethrow;
    }



   // print("data : $data");
  }

}