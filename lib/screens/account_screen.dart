import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  final Color mainColor = Color(0xFF29C17E);
  final LanguageManager _languageManager = LanguageManager();

  late AnimationController _controller;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
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
    _languageManager.removeListener(_onLanguageChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Opacity(
                opacity: 0.2 * _pulseAnim.value,
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF29C17E), width: 1),
                  ),
                ),
              ),
              // Inner glow
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFF29C17E).withOpacity(0.25 * _pulseAnim.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Logo circle
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(
                        color: Color(0xFF29C17E).withOpacity(0.4),
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
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              isArabic ? Icons.arrow_forward : Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLogoSection(),
              SizedBox(width: 8),
              Text(
                AppTranslations.get('account'),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: mainColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: mainColor, width: 2),
                      ),
                      child: Icon(Icons.person, size: 35, color: mainColor),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'user@example.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildOptionCard(
                icon: Icons.person_outline,
                titleKey: 'edit_profile',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppTranslations.get('coming_soon')),
                      backgroundColor: mainColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildOptionCard(
                icon: Icons.lock_outline,
                titleKey: 'change_password',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppTranslations.get('coming_soon')),
                      backgroundColor: mainColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildOptionCard(
                icon: Icons.email_outlined,
                titleKey: 'change_email',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppTranslations.get('coming_soon')),
                      backgroundColor: mainColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              _buildOptionCard(
                icon: Icons.delete_outline,
                titleKey: 'delete_account',
                titleColor: Colors.red,
                iconColor: Colors.red,
                onTap: () => _showDeleteDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String titleKey,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    bool isArabic = _languageManager.isArabic;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (iconColor ?? mainColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor ?? mainColor, size: 24),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                AppTranslations.get(titleKey),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? Colors.black87,
                ),
              ),
            ),
            Icon(
              isArabic ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: _languageManager.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              AppTranslations.get('delete_account'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Text(
              AppTranslations.get('delete_account_confirm'),
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppTranslations.get('cancel'),
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
                child: Text(
                  AppTranslations.get('delete'),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}