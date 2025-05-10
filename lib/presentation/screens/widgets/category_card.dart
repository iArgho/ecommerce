import 'package:eCommerce/application/theme/app_color.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;

  const CategoryCard({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.category,
              size: 50,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categoryName,
            style: const TextStyle(
              color: AppColor.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
