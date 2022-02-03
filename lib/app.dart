import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/repositories/product_repo.dart';
import 'package:telentproapp/screens/home_screen.dart';
import 'bloc/get_all_product_state.dart';
import 'bloc/product_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository productRepo = UserRepository();
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ProductCubit(GetAllProductInitial(),productRepo),),
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
