import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/models/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../repository/product_repository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    // Fetch all products
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await repository.fetchUser();
        emit(ProductLoaded(product, product, cart: [])); // Add empty cart list
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Search product
    on<SearchProduct>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        final query = event.query.toLowerCase();

        final filtered = currentState.product.where((product) {
          return product.title.toLowerCase().contains(query);
        }).toList();

        emit(currentState.copyWith(filteredProducts: filtered));
      }
    });

    // Add to cart
    on<AddToCart>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final updatedCart = List<Product>.from(currentState.cart);

        if (!updatedCart.contains(event.product)) {
          updatedCart.add(event.product);
        }

        emit(currentState.copyWith(cart: updatedCart));
      }
    });

    // Remove from cart
    on<RemoveFromCart>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final updatedCart = List<Product>.from(currentState.cart)
          ..remove(event.product);

        emit(currentState.copyWith(cart: updatedCart));
      }
    });
  }
}
