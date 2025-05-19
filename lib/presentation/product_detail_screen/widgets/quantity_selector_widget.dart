import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;
  final int maxQuantity;

  const QuantitySelectorWidget({
    Key? key,
    required this.quantity,
    required this.onChanged,
    required this.maxQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: 'remove',
            onPressed: () => onChanged(quantity - 1),
            isEnabled: quantity > 1,
          ),
          SizedBox(
            width: 10.w,
            child: Center(
              child: Text(
                quantity.toString(),
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
            ),
          ),
          _buildButton(
            icon: 'add',
            onPressed: () => onChanged(quantity + 1),
            isEnabled: quantity < maxQuantity,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.all(2.w),
        child: CustomIconWidget(
          iconName: icon,
          color: isEnabled ? AppTheme.textPrimary : AppTheme.textTertiary,
          size: 20,
        ),
      ),
    );
  }
}