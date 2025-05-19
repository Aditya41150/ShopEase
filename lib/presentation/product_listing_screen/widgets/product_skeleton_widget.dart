import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProductSkeletonWidget extends StatelessWidget {
  const ProductSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton for image
          Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.border.withAlpha(77),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          
          // Skeleton for product info
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for product name
                Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(77),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: 0.5.h),
                
                // Skeleton for second line of name
                Container(
                  height: 2.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(77),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: 1.h),
                
                // Skeleton for price
                Container(
                  height: 1.5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: AppTheme.border.withAlpha(77),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}