import 'dart:math';
import 'package:flutter/material.dart';
import 'package:eCommerce/data/model/product_model.dart';
import 'package:eCommerce/data/service/network/api_service.dart';
import 'package:eCommerce/presentation/screens/widgets/product_cart.dart';
import 'package:eCommerce/presentation/screens/widgets/product_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: ApiService.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              List<Product> products = snapshot.data!;
              final random = Random();
              final randomProducts =
                  (products.toList()..shuffle(random)).take(5).toList();

              final topRated =
                  products.where((p) => p.rating != null).toList()
                    ..sort((a, b) => b.rating.compareTo(a.rating!));
              final topRated9 = topRated.take(9).toList();

              final newlyArrived9 = products.reversed.take(9).toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCarousel(products: randomProducts),
                    const SizedBox(height: 20),

                    const Text(
                      'Top Rated',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      itemCount: topRated9.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        return ProductCard(product: topRated9[index]);
                      },
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'New Arrivals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      itemCount: newlyArrived9.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        return ProductCard(product: newlyArrived9[index]);
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
