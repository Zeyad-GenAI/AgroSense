import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Color mainColor = Color(0xFF29C17E);
  final LanguageManager _languageManager = LanguageManager();

  List<OnboardingData> _pages = [];

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
    _loadPages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _languageManager.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {
      _loadPages();
    });
  }

  void _loadPages() {
    _pages = [
      OnboardingData(
        image: 'assets/images/onboarding1.jpg',
        title: AppTranslations.get('onboarding_title_1'),
        description: AppTranslations.get('onboarding_desc_1'),
        accentColor: Color(0xFF29C17E),
      ),
      OnboardingData(
        image: 'assets/images/onboarding2.jpg',
        title: AppTranslations.get('onboarding_title_2'),
        description: AppTranslations.get('onboarding_desc_2'),
        accentColor: Color(0xFF22776A),
      ),
      OnboardingData(
        image: 'assets/images/onboarding3.jpg',
        title: AppTranslations.get('onboarding_title_3'),
        description: AppTranslations.get('onboarding_desc_3'),
        accentColor: Color(0xFF2E8B57),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Skip Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/welcome');
                      },
                      child: Text(
                        AppTranslations.get('skip'),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              // Bottom Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    // Page Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                            (index) => _buildIndicator(index),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Next/Get Started Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            Navigator.pushReplacementNamed(context, '/welcome');
                          } else {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? AppTranslations.get('get_started')
                              : AppTranslations.get('next'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),

          // Image with Border
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: data.accentColor.withOpacity(0.6),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: data.accentColor.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                data.image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 50),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          SizedBox(height: 20),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? mainColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;
  final Color accentColor;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    required this.accentColor,
  });
}