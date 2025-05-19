import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ProductSpecificationsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> specifications;

  const ProductSpecificationsWidget({
    Key? key,
    required this.specifications,
  }) : super(key: key);

  @override
  State<ProductSpecificationsWidget> createState() => _ProductSpecificationsWidgetState();
}

class _ProductSpecificationsWidgetState extends State<ProductSpecificationsWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                'Specifications',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              CustomIconWidget(
                iconName: _isExpanded ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: _buildSpecificationsList(),
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildSpecificationsList() {
    return Column(
      children: widget.specifications.map((spec) {
        return Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 35.w,
                child: Text(
                  spec["name"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  spec["value"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}