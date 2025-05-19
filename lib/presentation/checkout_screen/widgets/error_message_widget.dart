import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorType;
  final VoidCallback onRetry;

  const ErrorMessageWidget({
    Key? key,
    required this.errorType,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.error.withAlpha(26),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.error.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomIconWidget(
                iconName: 'error',
                color: AppTheme.error,
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text(
                _getErrorTitle(),
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.error,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 1.h),
          
          Text(
            _getErrorMessage(),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          
          SizedBox(height: 2.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onRetry,
                child: Text(_getActionText()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getErrorTitle() {
    switch (errorType) {
      case 'payment':
        return 'Payment Failed';
      case 'server':
        return 'Server Error';
      default:
        return 'Error';
    }
  }

  String _getErrorMessage() {
    switch (errorType) {
      case 'payment':
        return 'Your payment could not be processed. Please check your card details and try again.';
      case 'server':
        return 'We\'re experiencing technical difficulties. Please try again in a few moments.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  String _getActionText() {
    switch (errorType) {
      case 'payment':
        return 'Update Payment Details';
      case 'server':
        return 'Try Again';
      default:
        return 'Retry';
    }
  }
}