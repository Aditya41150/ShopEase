import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class CreditCardForm extends StatefulWidget {
  final Map<String, dynamic> paymentDetails;
  final Function(String, String) onUpdate;

  const CreditCardForm({
    Key? key,
    required this.paymentDetails,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final FocusNode _cardNumberFocus = FocusNode();
  final FocusNode _expiryDateFocus = FocusNode();
  final FocusNode _cvvFocus = FocusNode();
  final FocusNode _nameOnCardFocus = FocusNode();

  @override
  void dispose() {
    _cardNumberFocus.dispose();
    _expiryDateFocus.dispose();
    _cvvFocus.dispose();
    _nameOnCardFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Number
          TextFormField(
            initialValue: widget.paymentDetails['cardNumber'],
            focusNode: _cardNumberFocus,
            decoration: InputDecoration(
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: const CustomIconWidget(
                  iconName: 'credit_card',
                  color: AppTheme.textSecondary,
                  size: 24,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              _CardNumberFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              if (value.replaceAll(' ', '').length < 16) {
                return 'Please enter a valid 16-digit card number';
              }
              return null;
            },
            onChanged: (value) => widget.onUpdate('cardNumber', value),
            onFieldSubmitted: (_) => _expiryDateFocus.requestFocus(),
          ),
          
          SizedBox(height: 2.h),
          
          // Expiry Date and CVV in a row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expiry Date
              Expanded(
                child: TextFormField(
                  initialValue: widget.paymentDetails['expiryDate'],
                  focusNode: _expiryDateFocus,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryDateFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 5) {
                      return 'Invalid format';
                    }
                    
                    // Check if the expiry date is valid
                    final parts = value.split('/');
                    if (parts.length != 2) {
                      return 'Invalid format';
                    }
                    
                    final month = int.tryParse(parts[0]);
                    final year = int.tryParse('20${parts[1]}');
                    
                    if (month == null || year == null || month < 1 || month > 12) {
                      return 'Invalid date';
                    }
                    
                    final now = DateTime.now();
                    final expiryDate = DateTime(year, month + 1, 0);
                    
                    if (expiryDate.isBefore(now)) {
                      return 'Card expired';
                    }
                    
                    return null;
                  },
                  onChanged: (value) => widget.onUpdate('expiryDate', value),
                  onFieldSubmitted: (_) => _cvvFocus.requestFocus(),
                ),
              ),
              
              SizedBox(width: 2.w),
              
              // CVV
              Expanded(
                child: TextFormField(
                  initialValue: widget.paymentDetails['cvv'],
                  focusNode: _cvvFocus,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 3) {
                      return 'Invalid CVV';
                    }
                    return null;
                  },
                  onChanged: (value) => widget.onUpdate('cvv', value),
                  onFieldSubmitted: (_) => _nameOnCardFocus.requestFocus(),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 2.h),
          
          // Name on Card
          TextFormField(
            initialValue: widget.paymentDetails['nameOnCard'],
            focusNode: _nameOnCardFocus,
            decoration: const InputDecoration(
              labelText: 'Name on Card',
              hintText: 'Enter name as shown on card',
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name on card';
              }
              return null;
            },
            onChanged: (value) => widget.onUpdate('nameOnCard', value),
          ),
          
          SizedBox(height: 2.h),
          
          // Security Message
          Row(
            children: [
              const CustomIconWidget(
                iconName: 'lock',
                color: AppTheme.success,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Text(
                  'Your payment information is secure and encrypted',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom formatter for credit card number
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    
    // Remove all non-digits
    String value = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    // Format with spaces after every 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if ((i + 1) % 4 == 0 && i != value.length - 1) {
        buffer.write(' ');
      }
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

// Custom formatter for expiry date
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    
    // Remove all non-digits
    String value = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    // Format as MM/YY
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if (i == 1 && i != value.length - 1) {
        buffer.write('/');
      }
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}