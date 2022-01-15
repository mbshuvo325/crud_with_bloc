import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/add_product/add_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String price = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AddProductBloc,AddProductState>(
          listener: (context, state) {
            if(state is ApLoaded){
           BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas(5));

              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
              if (state is ApLoading) {
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is ApError){
                return Center(child: Text("Error"),);
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          name = value!;
                        });
                      },
                    ),
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          price = value!;
                        });
                      },
                    ),
                    TextButton(onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        BlocProvider.of<AddProductBloc>(context).add(AddProductEvent(name, price));
                      }
                    }, child: Text("Add Product")),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
