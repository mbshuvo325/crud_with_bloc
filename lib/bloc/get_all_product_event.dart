part of 'get_all_product_bloc.dart';

@immutable
abstract class GetAllProductEvent {

}
 class GetAllProductEventWithParmas implements GetAllProductEvent {
 final String? id;
  GetAllProductEventWithParmas({this.id});
 }
