import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'حساب وزن المعادن الملونة',
    home: MetalWeightCalculator(),
  ));
}

class MetalWeightCalculator extends StatefulWidget {
  @override
  _MetalWeightCalculatorState createState() => _MetalWeightCalculatorState();
}

class _MetalWeightCalculatorState extends State<MetalWeightCalculator> {
  final List<String> metals = ['نحاس', 'المنيوم', 'حديد'];
  String? selectedMetal = 'نحاس';
  String? shape = 'مستطيلة';
  double diameter = 0.0;
  double thickness = 0.0;
  double length = 0.0;
  double width = 0.0;
  double weight = 0.0;

  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController diameterController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lengthController.text = '';
    widthController.text = '';
    diameterController.text = '';
    thicknessController.text = '';
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    diameterController.dispose();
    thicknessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حساب وزن المعادن الملونة'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedMetal,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMetal = newValue;
                });
              },
              items: metals.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'اختر الشكل:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRadioButton('مستطيلة'),
                _buildRadioButton('مدورة'),
              ],
            ),
            SizedBox(height: 20),
            shape == 'مستطيلة'
                ? Column(
              children: <Widget>[
                _buildTextField(lengthController, 'الطول (سم)'),
                _buildTextField(widthController, 'العرض (سم)'),
              ],
            )
                : _buildTextField(diameterController, 'القطر (سم)'),
            SizedBox(height: 20),
            _buildTextField(thicknessController, 'السماكة (مم)'),
            SizedBox(height: 20),
            _buildElevatedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: shape,
          onChanged: (String? newValue) {
            setState(() {
              shape = newValue;
            });
          },
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          if (controller == lengthController)
            length = double.tryParse(value) ?? 0.0;
          else if (controller == widthController)
            width = double.tryParse(value) ?? 0.0;
          else if (controller == diameterController)
            diameter = double.tryParse(value) ?? 0.0;
          else if (controller == thicknessController)
            thickness = double.tryParse(value) ?? 0.0;
        });
      },
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if ((shape == 'مستطيلة' &&
            (lengthController.text.isEmpty ||
                widthController.text.isEmpty)) ||
            (shape == 'مدورة' && diameterController.text.isEmpty) ||
            thicknessController.text.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('خطأ'),
                content: Text('يجب ملء جميع الحقول'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('حسنا'),
                  ),
                ],
              );
            },
          );
        } else {
          double volume = shape == 'مستطيلة'
              ? length * width * thickness / 10000
              : 3.14 * (diameter / 2) * (diameter / 2) * thickness / 10000;

          weight = selectedMetal == 'نحاس'
              ? volume * 8.96
              : selectedMetal == 'المنيوم'
              ? volume * 2.7
              : volume * 7.87;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('الوزن المقدر:'),
                content: Text(
                  '${weight.toStringAsFixed(2)} كجم',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        lengthController.clear();
                        widthController.clear();
                        diameterController.clear();
                        thicknessController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('حسنا'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text(
        'حساب الوزن',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white60,
      ),
    );
  }
}
