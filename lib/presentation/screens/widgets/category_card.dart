import 'package:flutter/material.dart';
import 'package:eCommerce/application/theme/app_color.dart';
import 'package:eCommerce/presentation/screens/product/category_products_screen.dart';
import 'package:eCommerce/utils/category_utils.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;

  const CategoryCard({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final icon = getCategoryIcon(categoryName);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(category: categoryName),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 70, color: AppColor.primaryColor),
            ),
            const SizedBox(height: 4),
            Text(
              categoryName,
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
