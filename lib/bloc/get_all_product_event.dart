part of 'get_all_product_bloc.dart';

@immutable
abstract class GetAllProductEvent {}
 class GetAllProductEventWithParmas implements GetAllProductEvent {
  final int id;

  GetAllProductEventWithParmas(this.id);
 }
