import 'package:telentproapp/models/get_all_prouct_response.dart';

class GetAllProductState {

}

class GetAllProductInitial extends GetAllProductState {}
class GetAllProductLoading extends GetAllProductState {
  final String loadingText;
  GetAllProductLoading(this.loadingText);
}
class GetAllProductLoaded extends GetAllProductState {
  final List<Product> products;
  GetAllProductLoaded(this.products);
}
class GetAllProductError extends GetAllProductState {}
