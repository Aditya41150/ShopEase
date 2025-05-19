import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class OrderSummaryWidget extends StatelessWidget {
  final Map<String, dynamic> orderSummary;

  const OrderSummaryWidget({
    Key? key,
    required this.orderSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double subtotal = orderSummary["subtotal"] as double;
    final double tax = orderSummary["tax"] as double;
    final double shipping = orderSummary["shipping"] as double;
    final double total = orderSummary["total"] as double;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          
          // Subtotal
          _buildSummaryRow(
            label: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          
          // Tax
          _buildSummaryRow(
            label: 'Estimated Tax (8%)',
            value: '\$${tax.toStringAsFixed(2)}',
          ),
          
          // Shipping
          _buildSummaryRow(
            label: 'Shipping',
            value: shipping > 0 ? '\$${shipping.toStringAsFixed(2)}' : 'Free',
            valueStyle: shipping > 0 
                ? null 
                : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.success,
                    fontWeight: FontWeight.w500,
                  ),
          ),
          
          Divider(height: 3.h),
          
          // Total
          _buildSummaryRow(
            label: 'Order Total',
            value: '\$${total.toStringAsFixed(2)}',
            labelStyle: AppTheme.lightTheme.textTheme.titleSmall,
            valueStyle: AppTheme.getPriceTextStyle(
              isLight: true,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: labelStyle ?? AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: valueStyle ?? AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}