import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/app_header_widget.dart';
import './widgets/category_filter_widget.dart';
import './widgets/error_widget.dart';
import './widgets/product_grid_widget.dart';
import 'widgets/app_header_widget.dart';
import 'widgets/category_filter_widget.dart';
import 'widgets/error_widget.dart';
import 'widgets/product_grid_widget.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _hasError = false;
  bool _hasMoreData = true;
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _products = [];
  int _page = 1;
  final int _productsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMoreData) {
      _fetchMoreProducts();
    }
  }

  Future<void> _fetchProducts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
      _page = 1;
    });

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock data for products
      final List<Map<String, dynamic>> fetchedProducts = _getMockProducts(_page);
      
      setState(() {
        _products = fetchedProducts;
        _isLoading = false;
        _hasMoreData = fetchedProducts.length >= _productsPerPage;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _fetchMoreProducts() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Increment page number for pagination
      _page++;
      
      // Mock data for more products
      final List<Map<String, dynamic>> fetchedProducts = _getMockProducts(_page);
      
      setState(() {
        _products.addAll(fetchedProducts);
        _isLoading = false;
        _hasMoreData = fetchedProducts.length >= _productsPerPage;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  List<Map<String, dynamic>> _getMockProducts(int page) {
    // Filter products by category if needed
    final String category = _selectedCategory;
    
    // Base list of products
    final List<Map<String, dynamic>> allProducts = [
      {
        "id": 1 + ((page - 1) * _productsPerPage),
        "name": "Premium Wireless Headphones",
        "price": "\$299.99",
        "originalPrice": "\$349.99",
        "discount": "14%",
        "category": "Electronics",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://m.media-amazon.com/images/I/61oqO1AMbdL._SL1500_.jpg",
      },
      {
        "id": 2 + ((page - 1) * _productsPerPage),
        "name": "Smart Watch Series 5",
        "price": "\$199.99",
        "originalPrice": "\$249.99",
        "discount": "20%",
        "category": "Electronics",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 3 + ((page - 1) * _productsPerPage),
        "name": "Designer Leather Handbag",
        "price": "\$129.99",
        "originalPrice": "\$159.99",
        "discount": "19%",
        "category": "Fashion",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1584917865442-de89df76afd3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 4 + ((page - 1) * _productsPerPage),
        "name": "Running Shoes Pro",
        "price": "\$89.99",
        "originalPrice": null,
        "discount": null,
        "category": "Sports",
        "isOnSale": false,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 5 + ((page - 1) * _productsPerPage),
        "name": "Smartphone X Pro",
        "price": "\$899.99",
        "originalPrice": "\$999.99",
        "discount": "10%",
        "category": "Electronics",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1598327105666-5b89351aff97?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 6 + ((page - 1) * _productsPerPage),
        "name": "Stainless Steel Water Bottle",
        "price": "\$24.99",
        "originalPrice": null,
        "discount": null,
        "category": "Home",
        "isOnSale": false,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1602143407151-7111542de6e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 7 + ((page - 1) * _productsPerPage),
        "name": "Wireless Bluetooth Speaker",
        "price": "\$79.99",
        "originalPrice": "\$99.99",
        "discount": "20%",
        "category": "Electronics",
        "isOnSale": true,
        "inStock": false,
        "imageUrl": "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 8 + ((page - 1) * _productsPerPage),
        "name": "Yoga Mat Premium",
        "price": "\$45.99",
        "originalPrice": null,
        "discount": null,
        "category": "Sports",
        "isOnSale": false,
        "inStock": true,
        "imageUrl": "https://m.media-amazon.com/images/I/71VnAfLQGeL._AC_UL480_FMwebp_QL65_.jpg",
      },
      {
        "id": 9 + ((page - 1) * _productsPerPage),
        "name": "Ceramic Coffee Mug Set",
        "price": "\$34.99",
        "originalPrice": "\$39.99",
        "discount": "13%",
        "category": "Home",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
      {
        "id": 10 + ((page - 1) * _productsPerPage),
        "name": "Designer Sunglasses",
        "price": "\$149.99",
        "originalPrice": "\$189.99",
        "discount": "21%",
        "category": "Fashion",
        "isOnSale": true,
        "inStock": true,
        "imageUrl": "https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      },
    ];
    
    // Filter by category if not "All"
    if (category != 'All') {
      return allProducts.where((product) => product["category"] == category).toList();
    }
    
    return allProducts;
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
      });
      _fetchProducts();
    }
  }

  void _navigateToProductDetail(Map<String, dynamic> product) {
    Navigator.pushNamed(
      context, 
      '/product-detail-screen',
      arguments: product,
    );
  }

  void _navigateToCart() {
    Navigator.pushNamed(context, '/shopping-cart-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Header with Logo, Search and Cart
            AppHeaderWidget(
              cartItemCount: 3, // Mock cart item count
              onCartTap: _navigateToCart,
            ),
            
            // Category Filter
            CategoryFilterWidget(
              selectedCategory: _selectedCategory,
              onCategorySelected: _onCategorySelected,
            ),
            
            // Main Content
            Expanded(
              child: _hasError && _products.isEmpty
                  ? ErrorRetryWidget(onRetry: _fetchProducts)
                  : ProductGridWidget(
                      products: _products,
                      isLoading: _isLoading,
                      hasMoreData: _hasMoreData,
                      scrollController: _scrollController,
                      onProductTap: _navigateToProductDetail,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}