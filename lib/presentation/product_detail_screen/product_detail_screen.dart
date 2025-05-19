import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/add_to_cart_button_widget.dart';
import './widgets/error_widget.dart';
import './widgets/loading_widget.dart';
import './widgets/product_description_widget.dart';
import './widgets/product_image_carousel_widget.dart';
import './widgets/product_info_widget.dart';
import './widgets/product_rating_widget.dart';
import './widgets/product_specifications_widget.dart';
import './widgets/quantity_selector_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  int _quantity = 1;
  bool _isAddedToCart = false;
  late Map<String, dynamic> _productData;

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  Future<void> _fetchProductData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      _productData = {
        "id": 1,
        "name": "Premium Wireless Headphones",
        "description": """Experience crystal-clear sound with our Premium Wireless Headphones. 
        Featuring advanced noise cancellation technology, these headphones deliver an immersive audio experience whether you're commuting, working out, or relaxing at home.
        
        The ergonomic design ensures comfort during extended use, while the premium materials guarantee durability. With a battery life of up to 30 hours, you can enjoy your favorite music all day long.
        
        These headphones also come with touch controls for easy operation and a built-in microphone for hands-free calls. The sleek and modern design makes them a stylish accessory for any outfit.""",
        "price": "\$299.99",
        "originalPrice": "\$349.99",
        "discount": "14%",
        "rating": 4.7,
        "reviewCount": 253,
        "inStock": true,
        "stockQuantity": 10,
        "images": [
          "https://m.media-amazon.com/images/I/61oqO1AMbdL._SL1500_.jpg",
          "https://images.unsplash.com/photo-1577174881658-0f30ed549adc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
          "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80"
        ],
        "specifications": [
          {"name": "Brand", "value": "SoundMaster"},
          {"name": "Model", "value": "SM-WH100"}, 
          {"name": "Type", "value": "Over-ear"},
          {"name": "Connectivity", "value": "Bluetooth 5.0"},
          {"name": "Battery Life", "value": "30 hours"},
          {"name": "Charging Time", "value": "2 hours"},
          {"name": "Weight", "value": "250g"},
          {"name": "Color", "value": "Matte Black"},
          {"name": "Warranty", "value": "2 years"}
        ],
        "features": [
          "Active Noise Cancellation",
          "Touch Controls",
          "Voice Assistant Support",
          "Foldable Design",
          "Fast Charging",
          "Water Resistant (IPX4)"
        ]
      };
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _updateQuantity(int newQuantity) {
    final int maxQuantity = _productData["stockQuantity"] as int;
    
    if (newQuantity >= 1 && newQuantity <= maxQuantity) {
      setState(() {
        _quantity = newQuantity;
      });
    }
  }

  void _addToCart() {
    if (_productData["inStock"] as bool) {
      setState(() {
        _isAddedToCart = true;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added to cart!',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppTheme.success,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Reset button after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isAddedToCart = false;
          });
        }
      });
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sorry, this product is out of stock',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppTheme.error,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _navigateToCart() {
    Navigator.pushNamed(context, '/shopping-cart-screen');
  }

  void _navigateBack() {
    Navigator.pushNamed(context, '/product-listing-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
          onPressed: _navigateBack,
        ),
        actions: [
          IconButton(
            icon: const CustomIconWidget(
              iconName: 'shopping_cart',
              color: AppTheme.textPrimary,
              size: 24,
            ),
            onPressed: _navigateToCart,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget()
          : _hasError
              ? ProductErrorWidget(onRetry: _fetchProductData)
              : _buildProductDetails(),
      bottomNavigationBar: _isLoading || _hasError
          ? null
          : _buildBottomBar(),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Carousel
          ProductImageCarouselWidget(
            images: (_productData["images"] as List).map((item) => item as String).toList(),
          ),
          
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info (Name, Price)
                ProductInfoWidget(
                  name: _productData["name"] as String,
                  price: _productData["price"] as String,
                  originalPrice: _productData["originalPrice"] as String,
                  discount: _productData["discount"] as String,
                ),
                
                SizedBox(height: 2.h),
                
                // Product Rating
                ProductRatingWidget(
                  rating: _productData["rating"] as double,
                  reviewCount: _productData["reviewCount"] as int,
                ),
                
                SizedBox(height: 3.h),
                
                // Quantity Selector
                Row(
                  children: [
                    Text(
                      'Quantity:',
                      style: AppTheme.lightTheme.textTheme.titleSmall,
                    ),
                    SizedBox(width: 4.w),
                    QuantitySelectorWidget(
                      quantity: _quantity,
                      onChanged: _updateQuantity,
                      maxQuantity: _productData["stockQuantity"] as int,
                    ),
                    const Spacer(),
                    Text(
                      _productData["inStock"] as bool
                          ? '${_productData["stockQuantity"]} available'
                          : 'Out of Stock',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: _productData["inStock"] as bool
                            ? AppTheme.success
                            : AppTheme.error,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 3.h),
                
                // Product Description
                ProductDescriptionWidget(
                  description: _productData["description"] as String,
                ),
                
                SizedBox(height: 3.h),
                
                // Product Specifications
                ProductSpecificationsWidget(
                  specifications: (_productData["specifications"] as List)
                      .map((item) => item as Map<String, dynamic>)
                      .toList(),
                ),
                
                SizedBox(height: 3.h),
                
                // Product Features
                _buildFeatures(),
                
                SizedBox(height: 10.h), // Extra space at bottom for scrolling
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        ...(_productData["features"] as List).map((feature) {
          return Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.success,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    feature as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                Text(
                  _productData["price"] as String,
                  style: AppTheme.getPriceTextStyle(
                    isLight: true,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: AddToCartButtonWidget(
                onPressed: _addToCart,
                isAddedToCart: _isAddedToCart,
                isInStock: _productData["inStock"] as bool,
              ),
            ),
          ],
        ),
      ),
    );
  }
}