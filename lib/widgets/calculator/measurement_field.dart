import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Allows only valid positive decimal numbers (e.g. "12", "3.5", ".5").
/// Rejects any input that would leave the text as an invalid decimal.
class _DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    if (RegExp(r'^\d*\.?\d*$').hasMatch(text)) return newValue;
    return oldValue;
  }
}

class MeasurementField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool hasError;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const MeasurementField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.hasError = false,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      inputFormatters: [_DecimalInputFormatter()],
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
      decoration: InputDecoration(
        label: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            label,
            style: TextStyle(
              color: hasError
                  ? colorScheme.error
                  : colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: hasError ? colorScheme.error : colorScheme.primary,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
        errorText: hasError ? (errorText ?? '') : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError
                ? colorScheme.error
                : colorScheme.outline.withValues(alpha: 0.6),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? colorScheme.error : colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
    );
  }
}
