import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/screens/add_product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
print("ggg");
    BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas(5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: BlocBuilder<GetAllProductBloc, GetAllProductState>(
        builder: (context, state) {
          if (state is GetAllProductInitial) {
            return Container();
          }
          if (state is GetAllProductLoading) {
            return CircularProgressIndicator();
          }
          if (state is GetAllProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                var product = state.products[index];
                return ListTile(
                  leading: Text("${index+1}"),
                  title: Text(product.name!),
                  subtitle: Text(product.price!),
                );
              },
            );
          }
          if (state is GetAllProductError) {
            return Text("Error");
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have pushed the button this many times:',
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
