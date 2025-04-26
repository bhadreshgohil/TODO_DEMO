import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_bloc.dart';
import 'package:todo_app/app/todo_products/database_bloc/database_event.dart';
import 'package:todo_app/app/todo_products/pages/cart_list.dart';

import '../../../custom_component/image_custom_view.dart';
import '../../../theme/custom_text_style.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final response = context.read<TodoBloc>();
      await response.getProductList();
    },);
    super.initState();
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
        title: Text(widget.title),
        actions: [
          FilledButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(

            ),));
          }, child: Text("Cart"))
        ],
      ),
      body: BlocConsumer<TodoBloc,TodoState>(

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
                  trailing: FilledButton(onPressed: () async{
                    final dataBloc = context.read<DatabaseBloc>();
                    await dataBloc.createCart(CreateCartEvent(
                        getProductModel: data
                    ));

                  }, child: Text("Add to Cart")),
                  // trailing: Checkbox(value: data?.isSelected, onChanged: (value)async {
                  //   setState(() {
                  //
                  //   });
                  //     final dataBloc = context.read<DatabaseBloc>();
                  //     await dataBloc.createCart(CreateCartEvent(
                  //         getProductModel: data
                  //     ));
                  //
                  // },),
                  leading: data?.image != null ? Container(
                    height: 50,
                    width: 50,
                    child: CustomImageView(uri: data?.image ?? ""),
                  ) : SizedBox.shrink(),
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