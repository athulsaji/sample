import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/bloc/product_bloc.dart';
import 'package:sample/bloc/product_event.dart';
import 'package:sample/bloc/product_state.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.grey[900],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded && state.cart.isNotEmpty) {
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final product = state.cart[index];
                return ListTile(
                  leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text("\$${product.price}", style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      context.read<ProductBloc>().add(RemoveFromCart(product));
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Your cart is empty", style: TextStyle(color: Colors.white70)),
            );
          }
        },
      ),
    );
  }
}
