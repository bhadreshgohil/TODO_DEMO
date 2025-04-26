import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/todo_products/bloc/todo_bloc.dart';
import 'package:todo_app/app/todo_products/database/sqlite_database.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_bloc.dart';
import 'package:todo_app/app/todo_products/repository/sqlite_repository.dart';
import 'package:todo_app/app/todo_products/repository/todo_products_repository.dart';
import 'package:todo_app/usecases/todo_use_cases.dart';

class Blocs {
  static  Blocs blocs = Blocs();


  get _todoUseCase => TodoUseCase();
  get  _databaseUseCase => SqLiteDatabase();

  get  _todoProductsRepository => TodoProductsRepository(todoUseCase: _todoUseCase);
  get  _databaseRepository => SqLiteRepository(useCases: _databaseUseCase);

  get todoBloc => BlocProvider(create: (context) => TodoBloc(iTodoProductsRepository: _todoProductsRepository));
  get databaseBloc => BlocProvider(create: (context) => DatabaseBloc(databaseRepository: _databaseRepository));

}