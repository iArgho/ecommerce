import 'package:get/get.dart';
import 'package:eCommerce/data/model/product_model.dart';

class WishlistController extends GetxController {
  // Observable list of wishlist items
  var wishlist = <Product>[].obs;

  // Toggle product in wishlist
  void toggleWishlist(Product product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
  }

  // Check if product is in wishlist
  bool isInWishlist(Product product) {
    return wishlist.contains(product);
  }
}
