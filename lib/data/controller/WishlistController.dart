import 'package:get/get.dart';
import 'package:eCommerce/data/model/product_model.dart';

class WishlistController extends GetxController {
  var wishlist = <Product>[].obs;

  void toggleWishlist(Product product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
  }

  bool isInWishlist(Product product) {
    return wishlist.contains(product);
  }
}
