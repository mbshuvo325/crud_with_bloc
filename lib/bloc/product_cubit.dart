
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/models/add_product_request.dart';
import 'package:telentproapp/repositories/product_repo.dart';

import 'get_all_product_state.dart';


class ProductCubit extends Cubit<GetAllProductState>{
  ProductCubit(GetAllProductState initialState, this.productRepo) : super(initialState){
    getAllProduct("Getting Product");
  }
  final UserRepository productRepo;

  void getAllProduct(String text) async{
    try{
      emit(GetAllProductLoading(text));
      final product = await productRepo.getAllProduct();
      emit(GetAllProductLoaded(product));
    }catch (e){
      emit(GetAllProductError());
    }
  }

  addProduct(CreateProductRequest productRequest) async{
    await productRepo.createProduct(productRequest).then((value){
      getAllProduct("Adding Product");
    });
  }

  editProduct(CreateProductRequest productRequest) async{
    await productRepo.updateProduct(productRequest).then((value){
      getAllProduct("Editing Product");
    });
  }

  deleteProduct(String proId) async{
    await productRepo.deleteProduct(proId).then((value){
      getAllProduct("Deleting Product");
    });
  }
}