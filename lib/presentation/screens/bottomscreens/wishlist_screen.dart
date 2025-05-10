import 'package:eCommerce/application/theme/app_color.dart';
import 'package:eCommerce/data/controller/WishlistController.dart';
import 'package:eCommerce/presentation/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  final WishlistController wishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (wishlistController.wishlist.isEmpty) {
        return const Center(child: Text('Your wishlist is empty.'));
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: wishlistController.wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlistController.wishlist[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.network(product.image, width: 100, height: 100),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => wishlistController.toggleWishlist(product),
                ),
                onTap: () {
                  Get.to(() => ProductDetailsScreen(product: product));
                },
              ),
            );
          },
        ),
      );
    });
  }
}
