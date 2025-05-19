import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemPrice = item["price"] as double;
    final int quantity = item["quantity"] as int;
    final double totalPrice = itemPrice * quantity;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppTheme.border, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImageWidget(
                    imageUrl: item["image"] as String,
                    width: 25.w,
                    height: 25.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 3.w),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"] as String,
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '\$${itemPrice.toStringAsFixed(2)}',
                        style: AppTheme.getPriceTextStyle(
                          isLight: true,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      
                      // Quantity and Remove Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildQuantitySelector(),
                          IconButton(
                            onPressed: onRemove,
                            icon: const CustomIconWidget(
                              iconName: 'delete_outline',
                              color: AppTheme.error,
                              size: 22,
                            ),
                            tooltip: 'Remove item',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Item Total
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Item Total: ',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: AppTheme.getPriceTextStyle(
                      isLight: true,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    final int quantity = item["quantity"] as int;
    final int maxQuantity = item["maxQuantity"] as int;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            icon: 'remove',
            onPressed: () {
              if (quantity > 1) {
                onQuantityChanged(quantity - 1);
              }
            },
            isEnabled: quantity > 1,
          ),
          SizedBox(
            width: 8.w,
            child: Center(
              child: Text(
                quantity.toString(),
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
            ),
          ),
          _buildQuantityButton(
            icon: 'add',
            onPressed: () {
              if (quantity < maxQuantity) {
                onQuantityChanged(quantity + 1);
              }
            },
            isEnabled: quantity < maxQuantity,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required String icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.all(1.w),
        child: CustomIconWidget(
          iconName: icon,
          color: isEnabled ? AppTheme.textPrimary : AppTheme.textTertiary,
          size: 18,
        ),
      ),
    );
  }
}