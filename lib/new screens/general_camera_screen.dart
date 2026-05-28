import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

class GeneralCameraScreen extends StatefulWidget {
  @override
  _GeneralCameraScreenState createState() => _GeneralCameraScreenState();
}

class _GeneralCameraScreenState extends State<GeneralCameraScreen> {
  final LanguageManager _languageManager = LanguageManager();

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageManager.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Camera preview placeholder
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black87,
                child: Center(
                  child: Icon(Icons.camera_alt_outlined, size: 100, color: Colors.white24),
                ),
              ),

              // Top bar
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isArabic ? Icons.arrow_forward : Icons.arrow_back,
                          color: Colors.white, size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 8),
                      Text(
                        isArabic ? 'التقط صورة' : 'Take Photo',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom scan area
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Scanning frame
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF29C17E), width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(top: -3, left: -3,
                                child: Container(width: 40, height: 40,
                                    decoration: BoxDecoration(border: Border(
                                      top: BorderSide(color: Color(0xFF29C17E), width: 5),
                                      left: BorderSide(color: Color(0xFF29C17E), width: 5),
                                    )))),
                            Positioned(top: -3, right: -3,
                                child: Container(width: 40, height: 40,
                                    decoration: BoxDecoration(border: Border(
                                      top: BorderSide(color: Color(0xFF29C17E), width: 5),
                                      right: BorderSide(color: Color(0xFF29C17E), width: 5),
                                    )))),
                            Positioned(bottom: -3, left: -3,
                                child: Container(width: 40, height: 40,
                                    decoration: BoxDecoration(border: Border(
                                      bottom: BorderSide(color: Color(0xFF29C17E), width: 5),
                                      left: BorderSide(color: Color(0xFF29C17E), width: 5),
                                    )))),
                            Positioned(bottom: -3, right: -3,
                                child: Container(width: 40, height: 40,
                                    decoration: BoxDecoration(border: Border(
                                      bottom: BorderSide(color: Color(0xFF29C17E), width: 5),
                                      right: BorderSide(color: Color(0xFF29C17E), width: 5),
                                    )))),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        isArabic ? 'ضع النبات داخل الإطار' : 'Position plant within the frame',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      // Capture button
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isArabic ? 'جاري التحليل...' : 'Analyzing...'),
                              backgroundColor: Color(0xFF29C17E),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF29C17E).withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}