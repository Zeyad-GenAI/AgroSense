import 'dart:ui';
import 'package:flutter/material.dart';

class ForgetPasswordTwoScreen extends StatefulWidget {
  @override
  _ForgetPasswordTwoScreenState createState() => _ForgetPasswordTwoScreenState();
}

class _ForgetPasswordTwoScreenState extends State<ForgetPasswordTwoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.12 * _pulseAnim.value,
                child: Container(
                  width: 195, height: 195,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFEAF8BD), width: 1),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.22 * _pulseAnim.value,
                child: Container(
                  width: 165, height: 165,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFEAF8BD), width: 1.2),
                  ),
                ),
              ),
              Container(
                width: 140, height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFF1A6B5E).withOpacity(0.55 * _pulseAnim.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 125, height: 125,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                      border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.5),
                    ),
                    child: Image.asset(
                      'assets/images/argo.jpg',
                      fit: BoxFit.cover,
                      color: Colors.white,
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 18, right: 20,
                child: Opacity(
                  opacity: _pulseAnim.value,
                  child: Container(
                    width: 5, height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD),
                      boxShadow: [BoxShadow(color: Color(0xFFEAF8BD).withOpacity(0.9), blurRadius: 7, spreadRadius: 1)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20, left: 22,
                child: Opacity(
                  opacity: 1.0 - (_pulseAnim.value - 0.85) * 2,
                  child: Container(
                    width: 4, height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD),
                      boxShadow: [BoxShadow(color: Color(0xFFEAF8BD).withOpacity(0.7), blurRadius: 5, spreadRadius: 1)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF737C74), Color(0xFF22776A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Center(child: _buildLogoSection()),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check your email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We sent a reset link to your email.\nEnter the 5-digit code mentioned in the email.',
                    style: TextStyle(
                      color: Color(0xFFEAF8BD),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 36),
                  // OTP boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        width: 48,
                        height: 52,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Color(0xFFEAF8BD).withOpacity(0.7), width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend code',
                        style: TextStyle(
                          color: Color(0xFFEAF8BD),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFEAF8BD),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/forget3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF012626),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                        shadowColor: Color(0xFF012626).withOpacity(0.5),
                      ),
                      child: Text(
                        'VERIFY CODE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}