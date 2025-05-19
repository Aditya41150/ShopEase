import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ShippingAddressForm extends StatefulWidget {
  final Map<String, dynamic> shippingAddress;
  final Function(String, String) onUpdate;

  const ShippingAddressForm({
    Key? key,
    required this.shippingAddress,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
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
                'Shipping Address',
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
        
        // Form Fields
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              TextFormField(
                initialValue: widget.shippingAddress['fullName'],
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) => widget.onUpdate('fullName', value),
              ),
              
              SizedBox(height: 2.h),
              
              // Street Address
              TextFormField(
                initialValue: widget.shippingAddress['street'],
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  hintText: 'Enter your street address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
                onChanged: (value) => widget.onUpdate('street', value),
              ),
              
              SizedBox(height: 2.h),
              
              // City, State, Zip in a row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      initialValue: widget.shippingAddress['city'],
                      decoration: const InputDecoration(
                        labelText: 'City',
                        hintText: 'Enter city',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) => widget.onUpdate('city', value),
                    ),
                  ),
                  
                  SizedBox(width: 2.w),
                  
                  // State
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: widget.shippingAddress['state'],
                      decoration: const InputDecoration(
                        labelText: 'State',
                        hintText: 'Enter state',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) => widget.onUpdate('state', value),
                    ),
                  ),
                  
                  SizedBox(width: 2.w),
                  
                  // Zip Code
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: widget.shippingAddress['zipCode'],
                      decoration: const InputDecoration(
                        labelText: 'ZIP Code',
                        hintText: 'Enter ZIP',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(value)) {
                          return 'Invalid ZIP';
                        }
                        return null;
                      },
                      onChanged: (value) => widget.onUpdate('zipCode', value),
                    ),
                  ),
                ],
              ),
            ],
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}