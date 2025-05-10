import 'package:flutter/material.dart';

IconData getCategoryIcon(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'electronics':
      return Icons.devices;
    case 'jewelery':
      return Icons.diamond;
    case "men's clothing":
      return Icons.checkroom;
    case "women's clothing":
      return Icons.woman;
    default:
      return Icons.category;
  }
}
