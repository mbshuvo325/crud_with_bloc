part of 'get_all_product_bloc.dart';

@immutable
abstract class GetAllProductState {}

class GetAllProductInitial extends GetAllProductState {}
class GetAllProductLoading extends GetAllProductState {}
class GetAllProductLoaded extends GetAllProductState {
  final List<Product> products;

  GetAllProductLoaded(this.products);
}
class GetAllProductError extends GetAllProductState {}
