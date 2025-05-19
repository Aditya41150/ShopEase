import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class OrderSummaryWidget extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  const OrderSummaryWidget({
    Key? key,
    required this.orderItems,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  }) : super(key: key);

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: AppTheme.lightTheme.primaryTextTheme.headlineSmall,
              ),
              CustomIconWidget(
                iconName: _isExpanded ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 1.h),
        
        // Order Summary
        AnimatedCrossFade(
          firstChild: _buildCollapsedSummary(),
          secondChild: _buildExpandedSummary(),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildCollapsedSummary() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.orderItems.length} items',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Text(
            '\$${widget.total.toStringAsFixed(2)}',
            style: AppTheme.getPriceTextStyle(
              isLight: true,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedSummary() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Items
          ...widget.orderItems.map((item) => _buildOrderItem(item)),
          
          Divider(color: AppTheme.border, height: 4.h),
          
          // Price Breakdown
          _buildPriceRow('Subtotal', '\$${widget.subtotal.toStringAsFixed(2)}'),
          SizedBox(height: 1.h),
          _buildPriceRow('Shipping', '\$${widget.shipping.toStringAsFixed(2)}'),
          SizedBox(height: 1.h),
          _buildPriceRow('Tax', '\$${widget.tax.toStringAsFixed(2)}'),
          
          Divider(color: AppTheme.border, height: 4.h),
          
          // Total
          _buildPriceRow(
            'Total',
            '\$${widget.total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageWidget(
              imageUrl: item['image'] as String,
              width: 15.w,
              height: 15.w,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: 3.w),
          
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 0.5.h),
                
                Text(
                  'Quantity: ${item['quantity']}',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          
          SizedBox(width: 2.w),
          
          // Price
          Text(
            item['price'] as String,
            style: AppTheme.getPriceTextStyle(
              isLight: true,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTheme.lightTheme.textTheme.titleSmall
              : AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTheme.getPriceTextStyle(isLight: true, fontSize: 18)
              : AppTheme.getPriceTextStyle(isLight: true, fontSize: 14),
        ),
      ],
    );
  }
}