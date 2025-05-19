import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';

class ProductImageCarouselWidget extends StatefulWidget {
  final List<String> images;

  const ProductImageCarouselWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ProductImageCarouselWidget> createState() => _ProductImageCarouselWidgetState();
}

class _ProductImageCarouselWidgetState extends State<ProductImageCarouselWidget> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Hero(
                tag: 'product_image_${widget.images[index]}',
                child: CustomImageWidget(
                  imageUrl: widget.images[index],
                  width: 100.w,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        _buildImageIndicators(),
      ],
    );
  }

  Widget _buildImageIndicators() {
    return widget.images.length > 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => _buildIndicator(index),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? AppTheme.primaryColor
              : AppTheme.border,
        ),
      ),
    );
  }
}