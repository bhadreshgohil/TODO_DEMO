import 'package:todo_app/app/todo_products/database/sqlite_database.dart';

import '../data/response/todo_products_model.dart';

abstract class ISqLiteRepository {
  Future<int> createData({required GetProductModel dataModel});
  Future<List<GetProductModel>> getUserDetail();
}

class SqLiteRepository extends ISqLiteRepository{
  final ICrudUseCases? useCases;

  SqLiteRepository({this.useCases});

  @override
  Future<int> createData({required GetProductModel dataModel}) async{
    final response = await useCases?.createData(dataModel: dataModel);
    print("Check My response is $response");
    return response["status"];
  }

  @override
  Future<List<GetProductModel>> getUserDetail() async{
    List<GetProductModel> list = [];
    List<Map<String,dynamic>> mapList = await useCases?.getUserDetail();
    for(var element in mapList){
      list.add(GetProductModel.fromJson(element));
    }
    return list;
  }
}