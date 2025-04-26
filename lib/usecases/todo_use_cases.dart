import 'package:todo_app/config/apis.dart';
import 'package:todo_app/services/web_services.dart';

abstract class ITodoUseCase{
  Future<dynamic> getTodoProductListData();
  Future<dynamic> getCartListData();
}

class TodoUseCase extends ITodoUseCase{
  TodoUseCase();

  @override
  Future getTodoProductListData() async{
    final response = await WebService.instance.request(request: NetworkRequest(url: kGetProductsList,method: NetworkMethod.get));
    return response;
  }

  @override
  Future getCartListData() async{
    final response = await WebService.instance.request(request: NetworkRequest(url: kGetCartList,method: NetworkMethod.get));
    return response;
  }
}