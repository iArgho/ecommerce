import 'package:eCommerce/data/model/product_model.dart';
import 'package:eCommerce/data/service/network/api_service.dart';
import 'package:eCommerce/presentation/screens/widgets/product_cart.dart';
import 'package:flutter/material.dart';

enum ProductEvent { fetch, search, sort }

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTest> {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'None';

  @override
  void initState() {
    super.initState();
    dispatch(ProductEvent.fetch);
    _searchController.addListener(() => dispatch(ProductEvent.search));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void dispatch(ProductEvent event, {String? payload}) {
    switch (event) {
      case ProductEvent.fetch:
        _loadProducts();
        break;
      case ProductEvent.search:
        _onSearchChanged();
        break;
      case ProductEvent.sort:
        if (payload != null) _sortProducts(payload);
        break;
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _allProducts
              .where((product) => product.title.toLowerCase().contains(query))
              .toList();
      _applySorting();
    });
  }

  void _sortProducts(String option) {
    setState(() {
      _sortOption = option;
      _applySorting();
    });
  }

  void _applySorting() {
    if (_sortOption == 'Price: Low to High') {
      _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortOption == 'Price: High to Low') {
      _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiService.fetchProducts();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sort Dropdown
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _sortOption,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'None', child: Text('Sort')),
                        DropdownMenuItem(
                          value: 'Price: Low to High',
                          child: Text('Low to High'),
                        ),
                        DropdownMenuItem(
                          value: 'Price: High to Low',
                          child: Text('High to Low'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          dispatch(ProductEvent.sort, payload: value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Product Grid
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredProducts.isEmpty
                      ? const Center(child: Text('No products found.'))
                      : GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(16.0),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.80,
                        children:
                            _filteredProducts
                                .map((product) => ProductCard(product: product))
                                .toList(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
