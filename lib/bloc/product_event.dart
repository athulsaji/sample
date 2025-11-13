import 'package:sample/models/product_model.dart';


abstract class ProductEvent {}

class FetchProduct extends ProductEvent {}

class SearchProduct extends ProductEvent {
  final String query;
  SearchProduct(this.query);
}
class AddToCart extends ProductEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends ProductEvent {
  final Product product;
  RemoveFromCart(this.product);
}