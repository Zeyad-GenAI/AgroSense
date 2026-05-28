import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';
import 'package:plant_project/screens/account_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color mainColor = Color(0xFF29C17E);
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

  void _onLanguageChanged() {
    setState(() {});
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
          title: Text(
            AppTranslations.get('profile'),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: mainColor,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 22,
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

                SizedBox(height: 40),

                // Settings Section
                Text(
                  AppTranslations.get('settings'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 15),

                // Language Setting
                _buildSettingCard(
                  icon: Icons.language,
                  title: AppTranslations.get('app_language'),
                  subtitle: _languageManager.isArabic
                      ? AppTranslations.get('arabic')
                      : AppTranslations.get('english'),
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),

                SizedBox(height: 12),

                // Account Setting
                _buildSettingCard(
                  icon: Icons.person_outline,
                  title: AppTranslations.get('account'),
                  subtitle: AppTranslations.get('manage_account'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(height: 12),

                // Notifications Setting
                _buildSettingCard(
                  icon: Icons.notifications_outlined,
                  title: AppTranslations.get('notifications'),
                  subtitle: AppTranslations.get('notification_prefs'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    Icons.home_rounded,
                    AppTranslations.get('home'),
                    false,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                  ),
                  _navItem(
                    Icons.person_outline_rounded,
                    AppTranslations.get('profile'),
                    true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isSelected, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? mainColor : Colors.grey[400],
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? mainColor : Colors.grey[400],
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: mainColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(
          _languageManager.isArabic
              ? Icons.arrow_back_ios
              : Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog() {
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
              AppTranslations.get('select_language'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _languageOption('English', 'en'),
                SizedBox(height: 10),
                _languageOption('العربية', 'ar'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _languageOption(String language, String code) {
    bool isSelected = _languageManager.currentLanguage == code;

    return InkWell(
      onTap: () {
        _languageManager.setLanguage(code);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? mainColor.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? mainColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? mainColor : Colors.grey[400],
            ),
            SizedBox(width: 15),
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? mainColor : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}