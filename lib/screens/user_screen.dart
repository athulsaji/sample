import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/screens/cart_screen.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Center(child:  Text('INFINITE-STORE',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900, color: Colors.red),)),actions: [
   
    
            // BlocBuilder<ProductBloc, ProductState>(
            //   builder: (context, state) {
            //     int count = 0;
            //     if (state is ProductLoaded) {
            //       count = state.cart.length;
            //     }

            //     return Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         IconButton(
            //           icon: const Icon(Icons.shopping_cart),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (_) => const CartScreen()),
            //             );
            //           },
            //         ),
            //         if (count > 0)
            //           Positioned(
            //             right: 8,
            //             top: 8,
            //             child: Container(
            //               padding: const EdgeInsets.all(5),
            //               decoration: const BoxDecoration(
            //                 color: Colors.red,
            //                 shape: BoxShape.circle,
            //               ),
            //               child: Text(
            //                 count.toString(),
            //                 style: const TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //       ],
            //     );
            //   },
            // ),
          

  ],),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              // optional: store query temporarily if needed
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search product...',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) {
                              context.read<ProductBloc>().add(SearchProduct(value));
                            },
                          ),
                        ),
                      
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductLoaded) {
                      final products = state.filteredProducts;
                      if (products.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }
                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Price: \$${product.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                   const SizedBox(height: 10),

              // 🛒 Add to Cart Button
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                   context.read<ProductBloc>().add(AddToCart(product));
                  },
                ),
              ),
                ],
              ),
            )])));

                        },
                      );
                    } else if (state is ProductError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const Center(child: Text('Loading...'));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}