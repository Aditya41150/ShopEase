import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class OrderConfirmationWidget extends StatelessWidget {
  final String orderNumber;
  final DateTime estimatedDelivery;
  final VoidCallback onContinueShopping;

  const OrderConfirmationWidget({
    Key? key,
    required this.orderNumber,
    required this.estimatedDelivery,
    required this.onContinueShopping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            
            // Success Icon
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.success.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.success,
                  size: 10.w,
                ),
              ),
            ),
            
            SizedBox(height: 3.h),
            
            // Success Message
            Text(
              'Order Placed Successfully!',
              style: AppTheme.lightTheme.primaryTextTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 1.h),
            
            Text(
              'Thank you for your purchase',
              style: AppTheme.lightTheme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 4.h),
            
            // Order Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Number
                  _buildDetailRow(
                    'Order Number',
                    orderNumber,
                    icon: 'receipt',
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  // Estimated Delivery
                  _buildDetailRow(
                    'Estimated Delivery',
                    dateFormat.format(estimatedDelivery),
                    icon: 'local_shipping',
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  // Order Status
                  _buildDetailRow(
                    'Order Status',
                    'Processing',
                    icon: 'pending',
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  // Payment Status
                  _buildDetailRow(
                    'Payment Status',
                    'Paid',
                    icon: 'payments',
                    isSuccess: true,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 4.h),
            
            // Information Text
            Text(
              'We\'ve sent a confirmation email with all the details of your order.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 1.h),
            
            Text(
              'You can track your order status in the Orders section of your account.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 4.h),
            
            // Continue Shopping Button
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: onContinueShopping,
                child: const Text('Continue Shopping'),
              ),
            ),
            
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {
    required String icon,
    bool isSuccess = false,
  }) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: isSuccess ? AppTheme.success : AppTheme.primaryColor,
          size: 24,
        ),
        SizedBox(width: 3.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            SizedBox(height: 0.5.h),
            Text(
              value,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                color: isSuccess ? AppTheme.success : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}