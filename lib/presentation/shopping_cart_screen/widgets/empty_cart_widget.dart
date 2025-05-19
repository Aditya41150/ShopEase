import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const EmptyCartWidget({
    Key? key,
    required this.onContinueShopping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty cart icon
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'shopping_cart',
                  color: AppTheme.primaryColor,
                  size: 15.w.toDouble(),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            
            // Empty cart message
            Text(
              'Your cart is empty',
              style: AppTheme.lightTheme.primaryTextTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Looks like you haven\'t added any items to your cart yet.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            
            // Continue shopping button
            ElevatedButton.icon(
              onPressed: onContinueShopping,
              icon: const CustomIconWidget(
                iconName: 'shopping_bag',
                color: Colors.white,
                size: 20,
              ),
              label: const Text('Continue Shopping'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}