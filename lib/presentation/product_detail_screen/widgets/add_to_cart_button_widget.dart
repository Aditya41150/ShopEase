import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class AddToCartButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isAddedToCart;
  final bool isInStock;

  const AddToCartButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isAddedToCart,
    required this.isInStock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isInStock ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isAddedToCart ? AppTheme.success : null,
        disabledBackgroundColor: AppTheme.textTertiary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isAddedToCart)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CustomIconWidget(
                iconName: 'check',
                color: Colors.white,
                size: 20,
              ),
            ),
          Text(
            isAddedToCart
                ? 'Added to Cart'
                : isInStock
                    ? 'Add to Cart'
                    : 'Out of Stock',
          ),
        ],
      ),
    );
  }
}