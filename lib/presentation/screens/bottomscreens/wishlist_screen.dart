import 'package:eCommerce/application/theme/app_color.dart';
import 'package:eCommerce/data/controller/WishlistController.dart';
import 'package:eCommerce/presentation/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  final WishlistController wishlistController = Get.find();
  final RxSet<int> selectedIndexes = <int>{}.obs;
  final RxBool selectAll = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (wishlistController.wishlist.isEmpty) {
        return const Center(child: Text('Your wishlist is empty.'));
      }

      final wishlist = wishlistController.wishlist;

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return Obx(
                  () => Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: selectedIndexes.contains(index),
                        onChanged: (val) {
                          if (val == true) {
                            selectedIndexes.add(index);
                          } else {
                            selectedIndexes.remove(index);
                            selectAll.value = false;
                          }
                        },
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed:
                            () => wishlistController.toggleWishlist(product),
                      ),
                      onTap: () {
                        Get.to(() => ProductDetailsScreen(product: product));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: selectAll.value,
                    onChanged: (val) {
                      selectAll.value = val!;
                      if (val) {
                        selectedIndexes.addAll(
                          List.generate(wishlist.length, (i) => i),
                        );
                      } else {
                        selectedIndexes.clear();
                      }
                    },
                  ),
                ),
                const Text('Select All'),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed:
                      selectedIndexes.isEmpty
                          ? null
                          : () {
                            final selectedProducts =
                                selectedIndexes
                                    .map((i) => wishlist[i])
                                    .toList();
                            Get.snackbar(
                              "Buy Selected",
                              "${selectedProducts.length} item(s) selected.",
                            );
                          },
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text('Buy Selected'),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
