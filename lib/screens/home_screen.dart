import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

import '../new screens/chatbot_screen.dart';
import '../new screens/seasons_screen.dart';
import '../new screens/farming_tips_screen.dart';
import '../new screens/web_chat_screen.dart';
import '../scan screen/category_types_screen.dart';
import '../scan screen/crops_scan_screen.dart';
import '../scan screen/fruits_scan_screen.dart';
import '../scan screen/legumes_scan_screen.dart';
import '../scan screen/vegetables_scan_screen.dart';
import 'tip_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color mainColor = Color(0xFF29C17E);
  final Color barColor = Color(0xFF222B1D);
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
        floatingActionButton: _buildChatFAB(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: mainColor, size: 22),
                    SizedBox(width: 8),
                    Text("Malang, Indonesia", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
                    Spacer(),
                    Icon(Icons.notifications_none, color: Colors.black, size: 24),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppTranslations.get('search_plant'),
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: mainColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${AppTranslations.get('try_premium')}\n${AppTranslations.get('premium_desc')}",
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 9),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: Text(AppTranslations.get('get_it'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(AppTranslations.get('all_feature'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 1.09,
                  children: [
                    _featureCard(context, "crops", "assets/images/crops.png", CropsScanScreen()),
                    _featureCard(context, "vegetables", "assets/images/vegetables.png", VegetablesScanScreen()),
                    _featureCard(context, "fruits", "assets/images/fruits.png", FruitsScanScreen()),
                    _featureCard(context, "legumes", "assets/images/legumes.png", LegumesScanScreen()),
                  ],
                ),
                SizedBox(height: 19),
                Row(
                  children: [
                    Text(AppTranslations.get('seasonal_tips'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeasonsScreen())),
                      child: Text(isArabic ? '🌿 الفصول' : '🌿 Seasons', style: TextStyle(color: mainColor, fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FarmingTipsScreen())),
                      child: Text(AppTranslations.get('see_all'), style: TextStyle(color: mainColor, fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                _seasonalTipCard(
                  'rice',
                  'rice_tip',
                  Icons.water_drop,
                  Color(0xFF2196F3),
                  'assets/images/rice_growing.png',
                ),
                SizedBox(height: 12),
                _seasonalTipCard(
                  'wheat',
                  'wheat_tip',
                  Icons.wb_sunny,
                  Color(0xFFFFA726),
                  'assets/images/wheat_growing.png',
                ),
                SizedBox(height: 12),
                _seasonalTipCard(
                  'tomatoes',
                  'tomato_tip',
                  Icons.air,
                  Color(0xFF66BB6A),
                  'assets/images/tomato_growing.png',
                ),
                SizedBox(height: 80),
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
                  _navItem(Icons.home_rounded, AppTranslations.get('home'), true),
                  _navItem(
                    Icons.person_outline_rounded,
                    AppTranslations.get('profile'),
                    false,
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatFAB(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WebChatScreen())),
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF29C17E), Color(0xFF1A9E60)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Color(0xFF29C17E).withOpacity(0.5), blurRadius: 18, offset: Offset(0, 6)),
          ],
        ),
        child: Stack(
          children: [
            Center(child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 26)),
            Positioned(
              top: 11, right: 11,
              child: Container(
                width: 11, height: 11,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
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

  Widget _featureCard(BuildContext context, String categoryKey, String imgPath, Widget scanScreen) {
    String title = AppTranslations.get(categoryKey);
    String subtitle = AppTranslations.get('${categoryKey}_desc');

    List<Map<String, String>> types = [];

    if (categoryKey == "crops") {
      types = [
        {'name': AppTranslations.get('rice'), 'image': 'assets/images/rice.png'},
        {'name': AppTranslations.get('wheat'), 'image': 'assets/images/wheat.png'},
        {'name': AppTranslations.get('barley'), 'image': 'assets/images/barely.png'},
      ];
    } else if (categoryKey == "vegetables") {
      types = [
        {'name': AppTranslations.get('potatoes'), 'image': 'assets/images/potatoes.png'},
        {'name': AppTranslations.get('cucumber'), 'image': 'assets/images/cucumber.png'},
        {'name': AppTranslations.get('tomatoes'), 'image': 'assets/images/tomatoes.png'},
      ];
    } else if (categoryKey == "fruits") {
      types = [
        {'name': AppTranslations.get('banana'), 'image': 'assets/images/banana.png'},
        {'name': AppTranslations.get('apples'), 'image': 'assets/images/apples.png'},
      ];
    } else if (categoryKey == "legumes") {
      types = [
        {'name': AppTranslations.get('bean'), 'image': 'assets/images/bean.png'},
      ];
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryTypesScreen(
              categoryName: title,
              categoryImage: imgPath,
              scanScreen: scanScreen,
              types: types,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(imgPath, height: 78, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 7),
            Text(subtitle, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _seasonalTipCard(String plantNameKey, String tipKey, IconData icon, Color iconColor, String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TipDetailsScreen(
              plantNameKey: plantNameKey,
              tipKey: tipKey,
              icon: icon,
              iconColor: iconColor,
              imagePath: imagePath,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                AppTranslations.get(plantNameKey),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              _languageManager.isArabic
                  ? Icons.arrow_back_ios
                  : Icons.arrow_forward_ios,
              color: mainColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}