import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/add_product/add_product_bloc.dart';
import 'package:telentproapp/bloc/delete_product/delete_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/screens/home_screen.dart';

import 'bloc/edit_product/edit_product_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => GetAllProductBloc(),),
      BlocProvider(create: (context) => AddProductBloc(),),
      BlocProvider(create: (context) => EditProductBloc(),),
      BlocProvider(create: (context) => DeleteProductBloc(),),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
