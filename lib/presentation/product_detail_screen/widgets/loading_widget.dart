import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton for image
          Container(
            width: 100.w,
            height: 40.h,
            color: AppTheme.border.withAlpha(77),
          ),
          
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for title
                _buildSkeletonLine(width: 80.w, height: 3.h),
                SizedBox(height: 1.h),
                _buildSkeletonLine(width: 60.w, height: 3.h),
                
                SizedBox(height: 2.h),
                
                // Skeleton for price
                _buildSkeletonLine(width: 40.w, height: 2.5.h),
                
                SizedBox(height: 2.h),
                
                // Skeleton for rating
                _buildSkeletonLine(width: 30.w, height: 2.h),
                
                SizedBox(height: 3.h),
                
                // Skeleton for quantity selector
                Row(
                  children: [
                    _buildSkeletonLine(width: 20.w, height: 2.h),
                    SizedBox(width: 4.w),
                    _buildSkeletonLine(width: 25.w, height: 4.h),
                  ],
                ),
                
                SizedBox(height: 3.h),
                
                // Skeleton for description title
                _buildSkeletonLine(width: 50.w, height: 2.h),
                SizedBox(height: 1.h),
                
                // Skeleton for description content
                _buildSkeletonLine(width: 90.w, height: 2.h),
                SizedBox(height: 0.5.h),
                _buildSkeletonLine(width: 85.w, height: 2.h),
                SizedBox(height: 0.5.h),
                _buildSkeletonLine(width: 80.w, height: 2.h),
                
                SizedBox(height: 3.h),
                
                // Skeleton for specifications title
                _buildSkeletonLine(width: 40.w, height: 2.h),
                SizedBox(height: 1.h),
                
                // Skeleton for specifications content
                _buildSkeletonLine(width: 90.w, height: 2.h),
                SizedBox(height: 0.5.h),
                _buildSkeletonLine(width: 85.w, height: 2.h),
                SizedBox(height: 0.5.h),
                _buildSkeletonLine(width: 80.w, height: 2.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.border.withAlpha(77),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}