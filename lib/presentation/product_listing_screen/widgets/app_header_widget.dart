import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class AppHeaderWidget extends StatelessWidget {
  final int cartItemCount;
  final VoidCallback onCartTap;

  const AppHeaderWidget({
    Key? key,
    required this.cartItemCount,
    required this.onCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App Logo
          Row(
            children: [
              CustomIconWidget(
                iconName: 'shopping_bag',
                color: AppTheme.primaryColor,
                size: 28,
              ),
              SizedBox(width: 2.w),
              Text(
                'ShopEase',
                style: AppTheme.lightTheme.primaryTextTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          
          // Search and Cart Icons
          Row(
            children: [
              // Search Icon
              IconButton(
                icon: const CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.textPrimary,
                  size: 24,
                ),
                onPressed: () {
                  // Search functionality would go here
                },
                padding: EdgeInsets.all(2.w),
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              ),
              
              // Cart Icon with Badge
              Stack(
                children: [
                  IconButton(
                    icon: const CustomIconWidget(
                      iconName: 'shopping_cart',
                      color: AppTheme.textPrimary,
                      size: 24,
                    ),
                    onPressed: onCartTap,
                    padding: EdgeInsets.all(2.w),
                    constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 2.w,
                      top: 1.w,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          cartItemCount > 9 ? '9+' : cartItemCount.toString(),
                          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}