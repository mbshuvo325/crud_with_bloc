import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/models/add_product_request.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';
import 'package:telentproapp/repositories/product_repo.dart';

class EditProductEvent{
  final String id;
  final String name;
  final String price;

  EditProductEvent({required this.name,required this.price,required this.id});
}

abstract class EditProductState{

}

class EpInitial implements EditProductState{}
class EpLoading implements EditProductState{}
class EpLoaded implements EditProductState{
  final String success;
  EpLoaded(this.success);
}
class EpError implements EditProductState{}


class EditProductBloc extends Bloc<EditProductEvent, EditProductState>{
  final UserRepository _repository=UserRepository();
  EditProductBloc() : super(EpInitial()){
    on((EditProductEvent event, emit)async{
      emit(EpLoading());
      try {
        final res = await _repository.updateProduct(
            CreateProductRequest(name: event.name, price: event.price,id: event.id));
        emit(EpLoaded(res));
      }catch(e){
        emit(EpError());
      }
    });
  }
}