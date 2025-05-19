import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ProductRatingWidget({
    Key? key,
    required this.rating,
    required this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRatingStars(),
        SizedBox(width: 2.w),
        Text(
          rating.toString(),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          '($reviewCount reviews)',
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // Full star
          return const CustomIconWidget(
            iconName: 'star',
            color: AppTheme.warning,
            size: 20,
          );
        } else if (index == rating.floor() && rating % 1 > 0) {
          // Half star
          return const CustomIconWidget(
            iconName: 'star_half',
            color: AppTheme.warning,
            size: 20,
          );
        } else {
          // Empty star
          return const CustomIconWidget(
            iconName: 'star_border',
            color: AppTheme.warning,
            size: 20,
          );
        }
      }),
    );
  }
}