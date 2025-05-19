import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProductInfoWidget extends StatelessWidget {
  final String name;
  final String price;
  final String originalPrice;
  final String discount;

  const ProductInfoWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTheme.lightTheme.primaryTextTheme.displaySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 1.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              price,
              style: AppTheme.getPriceTextStyle(
                isLight: true,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              originalPrice,
              style: AppTheme.getOriginalPriceTextStyle(
                isLight: true,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.sale.withAlpha(26),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                discount + ' OFF',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.sale,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}