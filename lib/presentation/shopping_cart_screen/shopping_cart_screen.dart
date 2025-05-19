import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/cart_item_widget.dart';
import './widgets/empty_cart_widget.dart';
import './widgets/order_summary_widget.dart';
import 'widgets/cart_item_widget.dart';
import 'widgets/empty_cart_widget.dart';
import 'widgets/order_summary_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _cartItems = [];
  Map<String, dynamic> _orderSummary = {};
  bool _isProcessingCheckout = false;

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  Future<void> _fetchCartData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Mock cart data
      final List<Map<String, dynamic>> cartItems = [
        {
          "productId": 1,
          "name": "Premium Wireless Headphones",
          "price": 299.99,
          "quantity": 1,
          "image": "https://m.media-amazon.com/images/I/61oqO1AMbdL._SL1500_.jpg",
          "maxQuantity": 10,
        },
        {
          "productId": 2,
          "name": "Smart Watch Series 5",
          "price": 249.99,
          "quantity": 1,
          "image": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
          "maxQuantity": 5,
        },
      ];

      // Calculate order summary
      double subtotal = 0;
      for (var item in cartItems) {
        subtotal += (item["price"] as double) * (item["quantity"] as int);
      }

      final double taxRate = 0.08; // 8% tax
      final double tax = subtotal * taxRate;
      final double shipping = subtotal > 0 ? 10.00 : 0.00; // $10 shipping fee
      final double total = subtotal + tax + shipping;

      final Map<String, dynamic> orderSummary = {
        "subtotal": subtotal,
        "tax": tax,
        "shipping": shipping,
        "total": total,
      };

      setState(() {
        _cartItems = cartItems;
        _orderSummary = orderSummary;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _cartItems = [];
      });
    }
  }

  void _updateQuantity(int itemId, int newQuantity) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item["productId"] == itemId);
      if (index != -1) {
        // Optimistic UI update
        final oldQuantity = _cartItems[index]["quantity"] as int;
        _cartItems[index]["quantity"] = newQuantity;
        
        // Recalculate order summary
        _updateOrderSummary();
        
        // Simulate API call to update cart
        _simulateUpdateCartItem(itemId, newQuantity, index, oldQuantity);
      }
    });
  }

  Future<void> _simulateUpdateCartItem(int itemId, int newQuantity, int index, int oldQuantity) async {
    // Simulate API call with delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, handle API errors and revert if needed
    // For this demo, we'll assume success
  }

  void _removeItem(int itemId) {
    final index = _cartItems.indexWhere((item) => item["productId"] == itemId);
    if (index != -1) {
      final removedItem = _cartItems[index];
      
      // Remove item from cart
      setState(() {
        _cartItems.removeAt(index);
        _updateOrderSummary();
      });
      
      // Show snackbar with undo option
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Removed ${removedItem["name"]}',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Colors.white,
            onPressed: () {
              // Add item back to cart
              setState(() {
                _cartItems.insert(index, removedItem);
                _updateOrderSummary();
              });
            },
          ),
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _updateOrderSummary() {
    double subtotal = 0;
    for (var item in _cartItems) {
      subtotal += (item["price"] as double) * (item["quantity"] as int);
    }

    final double taxRate = 0.08; // 8% tax
    final double tax = subtotal * taxRate;
    final double shipping = subtotal > 0 ? 10.00 : 0.00; // $10 shipping fee
    final double total = subtotal + tax + shipping;

    setState(() {
      _orderSummary = {
        "subtotal": subtotal,
        "tax": tax,
        "shipping": shipping,
        "total": total,
      };
    });
  }

  void _navigateToCheckout() {
    if (_cartItems.isEmpty) return;
    
    setState(() {
      _isProcessingCheckout = true;
    });
    
    // Simulate processing delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isProcessingCheckout = false;
        });
        Navigator.pushNamed(context, '/checkout-screen');
      }
    });
  }

  void _navigateToProductListing() {
    Navigator.pushNamed(context, '/product-listing-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        leading: IconButton(
          icon: const CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
          onPressed: _navigateToProductListing,
        ),
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _cartItems.isEmpty
              ? EmptyCartWidget(onContinueShopping: _navigateToProductListing)
              : _buildCartContent(),
      bottomNavigationBar: _isLoading || _cartItems.isEmpty
          ? null
          : _buildBottomBar(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 2.h),
          Text(
            'Loading your cart...',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return Dismissible(
                key: Key('cart_item_${item["productId"]}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 4.w),
                  color: AppTheme.error,
                  child: const CustomIconWidget(
                    iconName: 'delete',
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                onDismissed: (direction) {
                  _removeItem(item["productId"] as int);
                },
                child: CartItemWidget(
                  item: item,
                  onQuantityChanged: (newQuantity) {
                    _updateQuantity(item["productId"] as int, newQuantity);
                  },
                  onRemove: () {
                    _removeItem(item["productId"] as int);
                  },
                ),
              );
            },
          ),
        ),
        OrderSummaryWidget(orderSummary: _orderSummary),
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
        child: ElevatedButton(
          onPressed: _isProcessingCheckout ? null : _navigateToCheckout,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            disabledBackgroundColor: AppTheme.textTertiary,
          ),
          child: _isProcessingCheckout
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    const Text('Processing...'),
                  ],
                )
              : const Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}