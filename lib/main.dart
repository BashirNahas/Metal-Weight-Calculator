import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF8F9FA),
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.7, curve: Curves.easeOut))
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.8, curve: Curves.easeOut))
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MetalWeightCalculator(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeInOutQuart;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF9A8C98).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/splash.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 40),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF9A8C98), Color(0xFFE9ECEF), Color(0xFF9A8C98)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Metal Weight Calculator',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 2,
                    width: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Color(0xFF9A8C98), Colors.transparent],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '@Bashir_Nahas',
                    style: TextStyle(
                      color: Color(0xFF9A8C98),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MetalWeightCalculator extends StatefulWidget {
  @override
  _MetalWeightCalculatorState createState() => _MetalWeightCalculatorState();
}

class _MetalWeightCalculatorState extends State<MetalWeightCalculator> with TickerProviderStateMixin {
  final List<String> metals = ['نحاس', 'المنيوم', 'حديد'];
  String? selectedMetal = 'نحاس';
  String? shape = 'مستطيلة';
  double diameter = 0.0;
  double thickness = 0.0;
  double length = 0.0;
  double width = 0.0;
  double weight = 0.0;

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController diameterController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, bool> fieldErrors = {
    'length': false,
    'width': false,
    'diameter': false,
    'thickness': false,
  };

  void resetValues() {
    setState(() {
      selectedMetal = 'نحاس';
      shape = 'مستطيلة';
      diameter = 0.0;
      thickness = 0.0;
      length = 0.0;
      width = 0.0;
      weight = 0.0;

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
    });
  }

  @override
  void initState() {
    super.initState();
    lengthController.text = '';
    widthController.text = '';
    diameterController.text = '';
    thicknessController.text = '';

    _buttonAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    diameterController.dispose();
    thicknessController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    bool isValid = true;

    setState(() {
      // Reset all errors
      fieldErrors = {
        'length': false,
        'width': false,
        'diameter': false,
        'thickness': false,
      };

      // Check thickness for both shapes
      if (thicknessController.text.isEmpty) {
        fieldErrors['thickness'] = true;
        isValid = false;
      }

      if (shape == 'مستطيلة') {
        // For rectangular shape
        if (lengthController.text.isEmpty) {
          fieldErrors['length'] = true;
          isValid = false;
        }

        if (widthController.text.isEmpty) {
          fieldErrors['width'] = true;
          isValid = false;
        }
      } else {
        // For circular shape
        if (diameterController.text.isEmpty) {
          fieldErrors['diameter'] = true;
          isValid = false;
        }
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حساب وزن المعادن',
          style: GoogleFonts.cairo(
            color: Color(0xFF22223B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            // Using ListView to allow scrolling if needed
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              children: <Widget>[
                _buildMetalSelector(),
                SizedBox(height: 12),
                _buildShapeSelector(),
                SizedBox(height: 12),
                _buildMeasurementsCard(),
                SizedBox(height: 16),
                _buildCalculateButton(context),
                SizedBox(height: 10), // Add some padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetalSelector() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category, color: Color(0xFF4A4E69), size: 22),
                SizedBox(width: 10),
                Text(
                  'اختر المعدن',
                  style: GoogleFonts.cairo(
                    color: Color(0xFF22223B),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: metals.map((metal) {
                bool isSelected = selectedMetal == metal;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMetal = metal;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFE9ECEF) : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected ? Color(0xFF4A4E69) : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ] : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getMetalIcon(metal),
                          color: isSelected ? Color(0xFF4A4E69) : Colors.grey.shade500,
                          size: 30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          metal,
                          style: GoogleFonts.cairo(
                            color: isSelected ? Color(0xFF22223B) : Colors.grey.shade600,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMetalIcon(String metal) {
    switch (metal) {
      case 'نحاس':
        return FontAwesomeIcons.ring; // Copper - lightning bolt icon
      case 'المنيوم':
        return FontAwesomeIcons.gears; // Aluminum - lightbulb icon
      case 'حديد':
        return FontAwesomeIcons.hammer; // Iron - hammer icon
      default:
        return Icons.category;
    }
  }

  Widget _buildShapeSelector() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category, color: Color(0xFF4A4E69), size: 22),
                SizedBox(width: 10),
                Text(
                  'اختر الشكل:',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22223B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRadioButton('مستطيلة', Icons.crop_landscape_rounded),
                SizedBox(width: 25),
                _buildRadioButton('مدورة', Icons.circle_outlined),
              ],
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.straighten, color: Color(0xFF4A4E69), size: 24),
                SizedBox(width: 10),
                Text(
                  'أدخل القياسات',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22223B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            shape == 'مستطيلة'
                ? Row(
              children: <Widget>[
                Expanded(child: _buildTextField(lengthController, 'الطول (سم)', Icons.height, 'length')),
                SizedBox(width: 12),
                Expanded(child: _buildTextField(widthController, 'العرض (سم)', Icons.width_normal, 'width')),
              ],
            )
                : _buildTextField(diameterController, 'القطر (سم)', Icons.radio_button_unchecked, 'diameter'),
            SizedBox(height: 14),
            _buildTextField(thicknessController, 'السماكة (مم)', Icons.layers, 'thickness'),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String value, IconData icon) {
    bool isSelected = shape == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          shape = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Color(0xFFE9ECEF) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xFF4A4E69) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ] : [],
        ),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Color(0xFF4A4E69) : Colors.grey.shade400,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Color(0xFF22223B) : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, String fieldName) {
    bool hasError = fieldErrors[fieldName] ?? false;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: hasError ? Colors.red.withOpacity(0.1) : Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            if (fieldName == 'length')
              length = double.tryParse(value) ?? 0.0;
            else if (fieldName == 'width')
              width = double.tryParse(value) ?? 0.0;
            else if (fieldName == 'diameter')
              diameter = double.tryParse(value) ?? 0.0;
            else if (fieldName == 'thickness')
              thickness = double.tryParse(value) ?? 0.0;

            // Clear error when user types
            if (value.isNotEmpty) {
              fieldErrors[fieldName] = false;
            }
          });
        },
        style: GoogleFonts.cairo(color: Color(0xFF22223B), fontSize: 15),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.cairo(
            color: hasError ? Colors.red : Colors.grey.shade600,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: hasError ? Colors.red : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: hasError ? Colors.red : Color(0xFF4A4E69),
                width: 2
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          prefixIcon: Icon(
            icon,
            color: hasError ? Colors.red : Color(0xFF4A4E69),
            size: 20,
          ),
          errorText: hasError ? 'مطلوب' : null,
          errorStyle: GoogleFonts.cairo(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _buttonAnimationController.forward(),
      onTapUp: (_) => _buttonAnimationController.reverse(),
      onTapCancel: () => _buttonAnimationController.reverse(),
      onTap: () {
        if (!validateInputs()) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'يرجى ملء جميع الحقول المطلوبة',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          return;
        }

        // Calculate weight logic here
        double density = 0.0;
        if (selectedMetal == 'نحاس') {
          density = 8.96;
        } else if (selectedMetal == 'المنيوم') {
          density = 2.7;
        } else if (selectedMetal == 'حديد') {
          density = 7.85;
        }

        double volume = 0.0;
        if (shape == 'مستطيلة') {
          volume = length * width * (thickness / 10);
        } else {
          volume = 3.14159 * (diameter / 2) * (diameter / 2) * (thickness / 10);
        }

        setState(() {
          weight = volume * density / 1000;
        });

        _showResultDialog(context);
      },
      child: ScaleTransition(
        scale: _buttonScaleAnimation,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Color(0xFF9A8C98), Color(0xFF4A4E69)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF4A4E69).withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calculate_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 8),
                Text(
                  'حساب الوزن',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/success_animation.json',
                  width: 120,
                  height: 120,
                  repeat: false,
                ),
                SizedBox(height: 10),
                Text(
                  'نتيجة الحساب',
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF22223B),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  height: 2,
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xFF9A8C98), Colors.transparent],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFF8F9FA),
                    border: Border.all(color: Color(0xFF9A8C98).withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.scale,
                        color: Color(0xFF4A4E69),
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'الوزن: ${weight.toStringAsFixed(3)} كغ',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22223B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9A8C98), Color(0xFF4A4E69)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      resetValues(); // Reset all values when dialog is closed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'حسناً',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}