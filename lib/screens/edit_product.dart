import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/bloc/add_product/add_product_bloc.dart';
import 'package:telentproapp/bloc/edit_product/edit_product_bloc.dart';
import 'package:telentproapp/bloc/get_all_product_bloc.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';
import 'package:telentproapp/screens/home_screen.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String price = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product".toUpperCase(),style: headerStyle,),
        ),
        body: BlocListener<EditProductBloc,EditProductState>(
          listener: (context, state) {
            if(state is EpLoaded){
           BlocProvider.of<GetAllProductBloc>(context).add(GetAllProductEventWithParmas());
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<EditProductBloc, EditProductState>(
            builder: (context, state) {
              if (state is EpLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20,),
                      Text('Editing product'.toUpperCase(),style: loadingStyle,)
                    ],
                  ),
                );
              }
              if(state is EpError){
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
                          initialValue: widget.product.name,
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
                          initialValue: widget.product.price,
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
                                BlocProvider.of<EditProductBloc>(context).add(EditProductEvent(name: name,id: widget.product.proId!,price: price));
                                setState(() {

                                });
                              }
                            },
                            child: Center(child: Text("Edit".toUpperCase(),style: headerStyle,),),
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
