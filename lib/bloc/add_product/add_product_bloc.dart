import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/models/add_product_request.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';
import 'package:telentproapp/repositories/product_repo.dart';

class AddProductEvent{
  final String name;
  final String price;
  AddProductEvent(this.name, this.price);
}

abstract class AddProductState{

}

class ApInitial implements AddProductState{}
class ApLoading implements AddProductState{}
class ApLoaded implements AddProductState{
  final String success;

  ApLoaded(this.success);
}
class ApError implements AddProductState{}


class AddProductBloc extends Bloc<AddProductEvent, AddProductState>{
  final UserRepository _repository=UserRepository();
  AddProductBloc() : super(ApInitial()){
    on((AddProductEvent event, emit)async{
      emit(ApLoading());
      try {
        final res = await _repository.createProduct(
            CreateProductRequest(name: event.name, price: event.price));
        emit(ApLoaded(res));
      }catch(e){
        emit(ApError());
      }
    });
  }
}