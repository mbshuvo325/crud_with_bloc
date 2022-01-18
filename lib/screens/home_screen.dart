import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/add_product/add_product_bloc.dart';
import 'package:telentproapp/bloc/delete_product/delete_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/screens/add_product.dart';
import 'package:telentproapp/screens/edit_product.dart';

const headerStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
const textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
const priceStyle = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 14,
  color: Colors.red
);
const loadingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.deepOrange
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page".toUpperCase(),style: headerStyle,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              icon: Icon(Icons.library_add),
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetAllProductBloc, GetAllProductState>(
        builder: (context, state) {
          if (state is GetAllProductInitial) {
            return Center(
              child: Text('Getting product'.toUpperCase(),style: loadingStyle,),
            );
          }
          if(state is GetAllProductLoading){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20,),
                  Text('Getting product'.toUpperCase(),style: loadingStyle,)
                ],
              ),
            );
          }
          if (state is GetAllProductLoaded) {
            return state.products.isNotEmpty ? ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                var product = state.products[state.products.length -1- index];
                return Card(
                  elevation: 5,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.5,
                                  child: Text(product.name!.toUpperCase(),overflow: TextOverflow.ellipsis,
                                    style: textStyle,)),
                              SizedBox(height: 8,),
                              Container(
                                  width: size.width * 0.5,
                                  child: Text("\u0024 "+product.price!,overflow: TextOverflow.ellipsis,
                                    style: priceStyle,)),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditProductPage(product: product,)));
                            },
                            icon: Icon(Icons.edit,color: Colors.blue,),
                          ),
                          IconButton(
                            onPressed: (){
                              showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ClassicGeneralDialogWidget(
                                    titleText: 'Do you want to delete ${product.name} ?',
                                    contentText: 'If delete once, ${product.name} will no longer available!',
                                    onPositiveClick: () {
                                        BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas(id: product.proId));
                                      Navigator.of(context).pop();
                                    },
                                    onNegativeClick: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                animationType: DialogTransitionType.size,
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(seconds: 1),
                              );
                            },
                            icon: Icon(Icons.delete_forever,color: Colors.red,),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ) : InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              child: Container(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Product Found'.toUpperCase(),style: headerStyle,),
                    SizedBox(height: 10,),
                    Text('tap to add product'.toUpperCase(),style: headerStyle,),
                  ],
                ),
              ),
            );
          }
          if (state is GetAllProductError) {
            return Text("Error");
          }
          return Center(
            child: Text('No product Found..!'),
          );
        },
      ),
    );
  }
}
