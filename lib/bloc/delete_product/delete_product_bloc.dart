import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telentproapp/repositories/product_repo.dart';

class DeleteProductEvent{
  final String id;
  DeleteProductEvent({required this.id});
}

abstract class DeleteProductState{

}

class DpInitial implements DeleteProductState{}
class DpLoading implements DeleteProductState{}
class DpLoaded implements DeleteProductState{
  final String success;

  DpLoaded(this.success);
}
class DpError implements DeleteProductState{}


class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState>{
  final UserRepository _repository=UserRepository();
  DeleteProductBloc() : super(DpInitial()){
    on((DeleteProductEvent event, emit)async{
      emit(DpLoading());
      try {
        final res = await _repository.deleteProduct(event.id);
        emit(DpLoaded(res));
      }catch(e){
        emit(DpError());
      }
    });
  }
}