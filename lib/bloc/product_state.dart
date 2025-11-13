

import 'package:sample/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;          
  final List<Product> filteredProducts; 
   final List<Product> cart; 

  ProductLoaded(this.product, this.filteredProducts, {
    this.cart = const [], 
  });

  ProductLoaded copyWith({
    List<Product>? product,
    List<Product>? filteredProducts,
   List<Product>? cart,
    
  }) {
    return ProductLoaded(
      product ?? this.product,
      filteredProducts ?? this.filteredProducts,
       cart:cart ?? this.cart,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
