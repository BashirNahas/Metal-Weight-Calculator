import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class CalculatorProvider extends ChangeNotifier {
  Metal _selectedMetal = Metal.copper;
  Shape _selectedShape = Shape.rectangle;

  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final diameterController = TextEditingController();
  final thicknessController = TextEditingController();

  Map<String, bool> fieldErrors = {
    'length': false,
    'width': false,
    'diameter': false,
    'thickness': false,
  };

  Calculation? _lastResult;

  Metal get selectedMetal => _selectedMetal;
  Shape get selectedShape => _selectedShape;
  Calculation? get lastResult => _lastResult;

  void selectMetal(Metal metal) {
    _selectedMetal = metal;
    notifyListeners();
  }

  void selectShape(Shape shape) {
    _selectedShape = shape;
    _clearShapeErrors();
    notifyListeners();
  }

  bool validate() {
    final errors = {
      'length': false,
      'width': false,
      'diameter': false,
      'thickness': false,
    };

    bool valid = true;

    final thickness = double.tryParse(thicknessController.text.trim());
    if (thickness == null || thickness <= 0) {
      errors['thickness'] = true;
      valid = false;
    }

    if (_selectedShape == Shape.rectangle) {
      final length = double.tryParse(lengthController.text.trim());
      if (length == null || length <= 0) {
        errors['length'] = true;
        valid = false;
      }
      final width = double.tryParse(widthController.text.trim());
      if (width == null || width <= 0) {
        errors['width'] = true;
        valid = false;
      }
    } else {
      final diameter = double.tryParse(diameterController.text.trim());
      if (diameter == null || diameter <= 0) {
        errors['diameter'] = true;
        valid = false;
      }
    }

    fieldErrors = errors;
    notifyListeners();
    return valid;
  }

  Calculation? calculate() {
    if (!validate()) return null;

    final thickness = double.parse(thicknessController.text.trim());
    final length = double.tryParse(lengthController.text.trim());
    final width = double.tryParse(widthController.text.trim());
    final diameter = double.tryParse(diameterController.text.trim());

    _lastResult = Calculation.compute(
      metal: _selectedMetal,
      shape: _selectedShape,
      length: length,
      width: width,
      diameter: diameter,
      thickness: thickness,
    );

    notifyListeners();
    return _lastResult;
  }

  void clearErrors() {
    fieldErrors = {
      'length': false,
      'width': false,
      'diameter': false,
      'thickness': false,
    };
    notifyListeners();
  }

  void reset() {
    _selectedMetal = Metal.copper;
    _selectedShape = Shape.rectangle;
    lengthController.clear();
    widthController.clear();
    diameterController.clear();
    thicknessController.clear();
    fieldErrors = {
      'length': false,
      'width': false,
      'diameter': false,
      'thickness': false,
    };
    _lastResult = null;
    notifyListeners();
  }

  void clearFieldError(String field) {
    if (fieldErrors[field] == true) {
      fieldErrors[field] = false;
      notifyListeners();
    }
  }

  void _clearShapeErrors() {
    fieldErrors['length'] = false;
    fieldErrors['width'] = false;
    fieldErrors['diameter'] = false;
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    diameterController.dispose();
    thicknessController.dispose();
    super.dispose();
  }
}
