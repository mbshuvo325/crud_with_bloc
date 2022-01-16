import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/add_product/add_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/screens/home_screen.dart';

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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Product".toUpperCase(),style: headerStyle,),
        ),
        body: BlocListener<AddProductBloc,AddProductState>(
          listener: (context, state) {
            if(state is ApLoaded){
           BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas());
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
              if (state is ApLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20,),
                      Text('Adding product'.toUpperCase(),style: loadingStyle,)
                    ],
                  ),
                );
              }
              if(state is ApError){
                return Center(child: Text("Error"),);
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Name con not be empty";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              name = value!;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: "Product Name".toUpperCase(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blue,width: 1
                                  )
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Price con not be empty";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              price = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "\u0024"+"Product Price".toUpperCase(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.blue,width: 1
                              )
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                        child: Container(
                          height: 60,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepOrange
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                BlocProvider.of<AddProductBloc>(context).add(AddProductEvent(name, price));
                              }
                            },
                            child: Center(child: Text("Add".toUpperCase(),style: headerStyle,),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
