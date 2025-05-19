import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './product_card_widget.dart';
import './product_skeleton_widget.dart';
import 'product_card_widget.dart';
import 'product_skeleton_widget.dart';

class ProductGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool isLoading;
  final bool hasMoreData;
  final ScrollController scrollController;
  final Function(Map<String, dynamic>) onProductTap;

  const ProductGridWidget({
    Key? key,
    required this.products,
    required this.isLoading,
    required this.hasMoreData,
    required this.scrollController,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(2.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
      ),
      itemCount: products.length + (isLoading ? 2 : 0),
      itemBuilder: (context, index) {
        // Show skeleton loaders at the end when loading more
        if (index >= products.length) {
          return const ProductSkeletonWidget();
        }
        
        // Show actual product cards
        final product = products[index];
        return ProductCardWidget(
          product: product,
          onTap: () => onProductTap(product),
        );
      },
    );
  }
}