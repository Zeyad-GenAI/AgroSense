import 'dart:ui';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

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

    // Fade + slide in on load
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _slideAnim = Tween<Offset>(
      begin: Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
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
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ring 3 - outermost
              Opacity(
                opacity: 0.12 * _pulseAnim.value,
                child: Container(
                  width: 255,
                  height: 255,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFEAF8BD), width: 1),
                  ),
                ),
              ),
              // Ring 2
              Opacity(
                opacity: 0.22 * _pulseAnim.value,
                child: Container(
                  width: 215,
                  height: 215,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFEAF8BD), width: 1.2),
                  ),
                ),
              ),
              // Ring 1
              Opacity(
                opacity: 0.35 * _pulseAnim.value,
                child: Container(
                  width: 178,
                  height: 178,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFEAF8BD), width: 1.5),
                  ),
                ),
              ),
              // Inner radial glow
              Container(
                width: 160,
                height: 160,
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
              // Glassmorphism circle with logo
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                        width: 1.5,
                      ),
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
              // Sparkle top-right
              Positioned(
                top: 20,
                right: 22,
                child: Opacity(
                  opacity: _pulseAnim.value,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFEAF8BD).withOpacity(0.9),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Sparkle bottom-left
              Positioned(
                bottom: 22,
                left: 24,
                child: Opacity(
                  opacity: 1.0 - (_pulseAnim.value - 0.85) * 2,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFEAF8BD).withOpacity(0.7),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Sparkle top-left
              Positioned(
                top: 50,
                left: 18,
                child: Opacity(
                  opacity: (_pulseAnim.value - 0.85) * 4,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD).withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              // Sparkle bottom-right
              Positioned(
                bottom: 48,
                right: 18,
                child: Opacity(
                  opacity: 1.0 - (_pulseAnim.value - 0.85) * 4,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF8BD).withOpacity(0.7),
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

  Widget _buildButton({
    required String label,
    required VoidCallback onTap,
    bool outlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withOpacity(0.6), width: 1.5),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white.withOpacity(0.08),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      )
          : ElevatedButton(
        onPressed: onTap,
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
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
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
          children: [
            SizedBox(height: 80),
            _buildLogoSection(),
            Spacer(),
            // Tagline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  // Thin divider line with dots
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFFEAF8BD).withOpacity(0.4),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '✦',
                          style: TextStyle(
                            color: Color(0xFFEAF8BD).withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFFEAF8BD).withOpacity(0.4),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                    label: 'Login',
                    onTap: () => Navigator.pushNamed(context, '/login'),
                  ),
                  SizedBox(height: 14),
                  _buildButton(
                    label: 'Sign up',
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    outlined: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}