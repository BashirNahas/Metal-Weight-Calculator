import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/calculation.dart';
import 'package:metal_weight_calculator/models/measurement_unit.dart';
import 'package:metal_weight_calculator/models/metal.dart';

class CalculatorProvider extends ChangeNotifier {
  Metal _selectedMetal = Metal.copper;
  Shape _selectedShape = Shape.rectangle;

  // Shared across shapes — semantics change per shape:
  //   length   → plate length (rect) | bar/pipe length (bar shapes)
  //   width    → plate width (rect)  | side (squareBar) | across-flats (hexBar)
  //   diameter → disc diameter (circle) | bar diameter (roundBar) | OD (pipe)
  //   thickness → plate/disc thickness in mm | pipe wall thickness in mm
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final diameterController = TextEditingController();
  final thicknessController = TextEditingController();

  // Thickness is almost always specified in mm even when the rest of the
  // measurements are in cm, so it gets its own unit independent of the
  // global measurement unit.
  MeasurementUnit _thicknessUnit = MeasurementUnit.mm;
  MeasurementUnit get thicknessUnit => _thicknessUnit;

  void setThicknessUnit(MeasurementUnit unit) {
    if (_thicknessUnit == unit) return;
    _thicknessUnit = unit;
    notifyListeners();
  }

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

    // thickness: required for plate/disc/pipe/tube; not used for solid bars
    final needsThickness = _selectedShape == Shape.rectangle ||
        _selectedShape == Shape.circle ||
        _selectedShape == Shape.pipe ||
        _selectedShape == Shape.squareTube;
    if (needsThickness) {
      final t = double.tryParse(thicknessController.text.trim());
      if (t == null || t <= 0) {
        errors['thickness'] = true;
        valid = false;
      }
    }

    // length: required for all except circle disc
    if (_selectedShape != Shape.circle) {
      final l = double.tryParse(lengthController.text.trim());
      if (l == null || l <= 0) {
        errors['length'] = true;
        valid = false;
      }
    }

    // width: required for rectangle, squareBar, hexBar, squareTube
    if (_selectedShape == Shape.rectangle ||
        _selectedShape == Shape.squareBar ||
        _selectedShape == Shape.hexBar ||
        _selectedShape == Shape.squareTube) {
      final w = double.tryParse(widthController.text.trim());
      if (w == null || w <= 0) {
        errors['width'] = true;
        valid = false;
      }
    }

    // diameter: required for circle, roundBar, pipe
    if (_selectedShape == Shape.circle ||
        _selectedShape == Shape.roundBar ||
        _selectedShape == Shape.pipe) {
      final d = double.tryParse(diameterController.text.trim());
      if (d == null || d <= 0) {
        errors['diameter'] = true;
        valid = false;
      }
    }

    fieldErrors = errors;
    notifyListeners();
    return valid;
  }

  Calculation? calculate({MeasurementUnit unit = MeasurementUnit.cm}) {
    if (!validate()) return null;

    final factor = unit.toCmFactor;
    final thickness = (double.tryParse(thicknessController.text.trim()) ?? 0) *
        _thicknessUnit.toCmFactor;
    final length = double.tryParse(lengthController.text.trim());
    final width = double.tryParse(widthController.text.trim());
    final diameter = double.tryParse(diameterController.text.trim());

    _lastResult = Calculation.compute(
      metal: _selectedMetal,
      shape: _selectedShape,
      length: length == null ? null : length * factor,
      width: width == null ? null : width * factor,
      diameter: diameter == null ? null : diameter * factor,
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
    _thicknessUnit = MeasurementUnit.mm;
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
    fieldErrors['thickness'] = false;
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
