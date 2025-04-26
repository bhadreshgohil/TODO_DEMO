import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_bloc.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_state.dart';

import '../../../custom_component/image_custom_view.dart';
import '../../../theme/custom_text_style.dart';
import '../data/response/todo_products_model.dart';
class ProductDetailPage extends StatefulWidget {
  final GetProductModel? getProductModel;
  const ProductDetailPage({super.key, this.getProductModel});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await context.read<DatabaseBloc>().getCartData();
    },);

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        actions: [
          FilledButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(

            ),));
          }, child: Text("Cart"))
        ],
      ),
      body: BlocConsumer<DatabaseBloc,DatabaseState>(

        builder: (context, state) {
          if(state is LoadingTodoState){
            return CircularProgressIndicator();
          }else if(state is ErrorTodoState){
            return Center(child: Text(state.error ?? ""),);
          }else if(state is SuccessTodoState){
            return ListView.separated(
              itemCount: (state.list?.length ?? 0),
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final data = state.list?[index];
                return ListTile(
                  onTap: () async{

                  },
                  title: Text(data?.title ?? "",style: kPrimaryTextStyle,),
                  subtitle: Text(data?.description ?? "",style: kPrimaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),),
                );
              },);
          }else{
            return Container();
          }
        }, listener: (context, state) {

      },),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //
      //   },
      //   label: Text('Add to Cart'),
      //   icon: Icon(Icons.add),
      //   backgroundColor: Colors.purple,
      // ),
    );

  }
}
