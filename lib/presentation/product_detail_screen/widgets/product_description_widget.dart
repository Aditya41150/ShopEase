import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ProductDescriptionWidget extends StatefulWidget {
  final String description;

  const ProductDescriptionWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductDescriptionWidget> createState() => _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
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
                'Product Description',
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
            child: Text(
              widget.description,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}