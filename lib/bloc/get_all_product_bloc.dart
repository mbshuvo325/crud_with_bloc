import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:telentproapp/models/get_all_prouct_response.dart';
import 'package:telentproapp/repositories/product_repo.dart';

part 'get_all_product_event.dart';

part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final UserRepository _repository = UserRepository();

  GetAllProductBloc() : super(GetAllProductInitial()) {
    on<GetAllProductEvent>((event, emit) async {
      if (event is GetAllProductEventWithParmas) {
        // emit(GetAllProductLoading());
        try {
          final list = await _repository.getAllProduct();

          emit(GetAllProductLoaded(list));
        } catch (e) {
          emit(GetAllProductError());
        }
      }
    });
  }
}

