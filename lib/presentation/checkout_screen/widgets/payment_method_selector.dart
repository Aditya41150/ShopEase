import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PaymentMethodSelector extends StatefulWidget {
  final String selectedMethod;
  final Function(String) onSelect;

  const PaymentMethodSelector({
    Key? key,
    required this.selectedMethod,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
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
                'Payment Method',
                style: AppTheme.lightTheme.primaryTextTheme.headlineSmall,
              ),
              CustomIconWidget(
                iconName: _isExpanded ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 1.h),
        
        // Payment Methods
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Column(
            children: [
              _buildPaymentMethodTile(
                method: 'creditCard',
                title: 'Credit Card',
                icon: 'credit_card',
                subtitle: 'Pay with Visa, Mastercard, etc.',
              ),
              
              // For MVP, we only show credit card option
              // In the future, more payment methods can be added here
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  'More payment methods coming soon',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile({
    required String method,
    required String title,
    required String icon,
    required String subtitle,
  }) {
    final bool isSelected = widget.selectedMethod == method;
    
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppTheme.primaryColor : AppTheme.border,
          width: isSelected ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RadioListTile<String>(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
        value: method,
        groupValue: widget.selectedMethod,
        onChanged: (value) {
          if (value != null) {
            widget.onSelect(value);
          }
        },
        activeColor: AppTheme.primaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      ),
    );
  }
}