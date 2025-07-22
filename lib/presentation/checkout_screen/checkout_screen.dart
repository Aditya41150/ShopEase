import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/checkout_button.dart';
import './widgets/credit_card_form.dart';
import './widgets/error_message_widget.dart';
import './widgets/order_confirmation_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/payment_method_selector.dart';
import './widgets/shipping_address_form.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isOrderPlaced = false;
  bool _hasError = false;
  String _errorType = '';
  String _orderNumber = '';
  DateTime _estimatedDelivery = DateTime.now().add(const Duration(days: 5));
  
  // Form data
  final Map<String, dynamic> _shippingAddress = {
  "fullName": "",
  "street": "",
  "city": "",
  "state": "",
  "zipCode": "",
  };
  
  final Map<String, dynamic> _paymentDetails = {
  "cardNumber": "",
  "expiryDate": "",
  "cvv": "",
  "nameOnCard": "",
  };
  
  String _selectedPaymentMethod = 'creditCard';
  
  // Mock order items
  final List<Map<String, dynamic>> _orderItems = [
    {
      "productId": 1,
      "name": "Premium Wireless Headphones",
      "price": "\$299.99",
      "quantity": 1,
      "image": "https://m.media-amazon.com/images/I/61oqO1AMbdL._SL1500_.jpg",
    },
    {
      "productId": 2,
      "name": "Smart Watch Series 5",
      "price": "\$199.99",
      "quantity": 1,
      "image": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
    }
  ];
  
  double _subtotal = 499.98;
  double _shipping = 9.99;
  double _tax = 25.00;
  double _total = 534.97;
  
  void _updateShippingAddress(String field, String value) {
    setState(() {
      _shippingAddress[field] = value;
    });
  }
  
  void _updatePaymentDetails(String field, String value) {
    setState(() {
      _paymentDetails[field] = value;
    });
  }
  
  void _setPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }
  
  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
  
  Future<void> _placeOrder() async {
    if (!_validateForm()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    
    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 3));
    
    // Simulate random success/error scenarios
    final random = DateTime.now().millisecond % 10;
    
    if (random < 8) {
      // Success (80% chance)
      setState(() {
        _isLoading = false;
        _isOrderPlaced = true;
        _orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}';
      });
    } else {
      // Error (20% chance)
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorType = random == 8 ? 'payment' : 'server';
      });
    }
  }
  
  void _retryOrder() {
    setState(() {
      _hasError = false;
    });
  }
  
  void _continueShopping() {
    Navigator.pushNamed(context, '/product-listing-screen');
  }
  
  void _navigateToCart() {
    Navigator.pushNamed(context, '/shopping-cart-screen');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
          onPressed: () => Navigator.pushNamed(context, '/shopping-cart-screen'),
        ),
      ),
      body: _isOrderPlaced
          ? OrderConfirmationWidget(
              orderNumber: _orderNumber,
              estimatedDelivery: _estimatedDelivery,
              onContinueShopping: _continueShopping,
            )
          : _buildCheckoutForm(),
    );
  }
  
  Widget _buildCheckoutForm() {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shipping Address Form
                ShippingAddressForm(
                  shippingAddress: _shippingAddress,
                  onUpdate: _updateShippingAddress,
                ),
                
                SizedBox(height: 4.h),
                
                // Payment Method Selector
                PaymentMethodSelector(
                  selectedMethod: _selectedPaymentMethod,
                  onSelect: _setPaymentMethod,
                ),
                
                SizedBox(height: 3.h),
                
                // Credit Card Form
                if (_selectedPaymentMethod == 'creditCard')
                  CreditCardForm(
                    paymentDetails: _paymentDetails,
                    onUpdate: _updatePaymentDetails,
                  ),
                
                SizedBox(height: 4.h),
                
                // Order Summary
                OrderSummaryWidget(
                  orderItems: _orderItems,
                  subtotal: _subtotal,
                  shipping: _shipping,
                  tax: _tax,
                  total: _total,
                ),
                
                SizedBox(height: 3.h),
                
                // Error Message
                if (_hasError)
                  ErrorMessageWidget(
                    errorType: _errorType,
                    onRetry: _retryOrder,
                  ),
                
                SizedBox(height: 2.h),
                
                // Checkout Button
                CheckoutButton(
                  onPressed: _placeOrder,
                  isFormValid: _validateForm(),
                ),
                
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
        
        // Loading Overlay
        if (_isLoading)
          Container(
            color: Colors.black.withAlpha(128),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Processing your order...',
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}