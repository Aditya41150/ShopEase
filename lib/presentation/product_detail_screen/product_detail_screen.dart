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
  int _quantity = 1;
  bool _isAddedToCart = false;
  Map<String, dynamic>? _productData;

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  Future<void> _fetchProductData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    // Use mock product data
    _productData = {
      "name": "Sample Product",
      "price": "\$49.99",
      "originalPrice": "\$59.99",
      "discount": "17%",
      "rating": 4.5,
      "reviewCount": 123,
      "stockQuantity": 10,
      "inStock": true,
      "description": "This is a sample product description.",
      "images": [
        "https://via.placeholder.com/300x200",
        "https://via.placeholder.com/300x200?2"
      ],
      "specifications": [
        {"Key": "Color", "Value": "Red"},
        {"Key": "Size", "Value": "Medium"}
      ],
      "features": [
        "High quality material",
        "Ergonomic design",
        "Affordable price"
      ]
    };
    setState(() {
      _isLoading = false;
    });
  }

  void _updateQuantity(int newQuantity) {
    if (_productData == null) return;
    final int maxQuantity = _productData!["stockQuantity"] as int;
    if (newQuantity >= 1 && newQuantity <= maxQuantity) {
      setState(() {
        _quantity = newQuantity;
      });
    }
  }

  void _addToCart() {
    if (_productData == null) return;
    if (_productData!["inStock"] as bool) {
      setState(() {
        _isAddedToCart = true;
      });
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
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isAddedToCart = false;
          });
        }
      });
    } else {
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
    if (_isLoading) {
      return const LoadingWidget();
    }
    if (_productData == null) {
      return const Scaffold(
        body: Center(child: Text('Error loading product data')),
      );
    }
    try {
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
        body: _buildProductDetails(),
        bottomNavigationBar: _buildBottomBar(),
      );
    } catch (e, stack) {
      debugPrint('Error building ProductDetailScreen: \n'
          'Error: \n'
          ' [31m${e.toString()}\n' + stack.toString());
      return Scaffold(
        body: Center(child: Text('Error: ' + e.toString())),
      );
    }
  }
  
  Widget _buildProductDetails() {
    if (_productData == null) {
      return const Center(child: Text('No product data available'));
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageCarouselWidget(
            images: (_productData!["images"] as List).map((item) => item as String).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductInfoWidget(
                  name: _productData!["name"] as String,
                  price: _productData!["price"] as String,
                  originalPrice: _productData!["originalPrice"] as String,
                  discount: _productData!["discount"] as String,
                ),
                SizedBox(height: 2.h),
                ProductRatingWidget(
                  rating: (_productData!["rating"] as num).toDouble(),
                  reviewCount: _productData!["reviewCount"] as int,
                ),
                SizedBox(height: 3.h),
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
                      maxQuantity: _productData!["stockQuantity"] as int,
                    ),
                    const Spacer(),
                    Text(
                      _productData!["inStock"] as bool
                          ? '${_productData!["stockQuantity"]} available'
                          : 'Out of Stock',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: _productData!["inStock"] as bool
                            ? AppTheme.success
                            : AppTheme.error,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                ProductDescriptionWidget(
                  description: _productData!["description"] as String,
                ),
                SizedBox(height: 3.h),
                ProductSpecificationsWidget(
                  specifications: (_productData!["specifications"] as List)
                      .map((item) => Map<String, dynamic>.from(item as Map))
                      .toList(),
                ),
                SizedBox(height: 3.h),
                _buildFeatures(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    if (_productData == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 1.h),
        ...(_productData!["features"] as List).map((feature) {
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
    if (_productData == null) {
      return const SizedBox.shrink();
    }
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
                  _productData!["price"] as String,
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
                isInStock: _productData!["inStock"] as bool,
              ),
            ),
          ],
        ),
      ),
    );
  }
}