import 'package:flutter/material.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._internal();
  factory LanguageManager() => _instance;
  LanguageManager._internal();

  String _currentLanguage = 'en';
  final List<VoidCallback> _listeners = [];

  String get currentLanguage => _currentLanguage;
  bool get isArabic => _currentLanguage == 'ar';
  bool get isEnglish => _currentLanguage == 'en';

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == 'en' ? 'ar' : 'en';
    _notifyListeners();
  }

  void setLanguage(String language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      _notifyListeners();
    }
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}

class AppTranslations {
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      // Profile Screen
      'profile': 'Profile',
      'settings': 'Settings',
      'language': 'Language',
      'english': 'English',
      'arabic': 'العربية',
      'select_language': 'Select Language',
      'app_language': 'App Language',
      'account': 'Account',
      'notifications': 'Notifications',
      'privacy': 'Privacy',
      'help': 'Help & Support',
      'about': 'About',
      'logout': 'Logout',
      'manage_account': 'Manage your account',
      'notification_prefs': 'Notification preferences',

      // Account Screen
      'edit_profile': 'Edit Profile',
      'change_password': 'Change Password',
      'change_email': 'Change Email',
      'delete_account': 'Delete Account',
      'delete_account_confirm': 'Are you sure you want to delete your account? This action cannot be undone.',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'coming_soon': 'Coming Soon',

      // Notifications Screen
      'notification_settings_desc': 'Manage your notification preferences',
      'notification_types': 'Notification Types',
      'push_notifications': 'Push Notifications',
      'push_notifications_desc': 'Receive alerts on your device',
      'email_notifications': 'Email Notifications',
      'email_notifications_desc': 'Get updates via email',
      'tips_notifications': 'Daily Tips',
      'tips_notifications_desc': 'Receive plant care tips',
      'scan_reminders': 'Scan Reminders',
      'scan_reminders_desc': 'Reminders to scan your plants',

      // Home Screen
      'home': 'Home',
      'search_plant': 'Search Plant',
      'all_feature': 'All Feature',
      'seasonal_tips': 'Seasonal Tips',
      'see_all': 'See all',
      'try_premium': 'Try Premium Features 🌿',
      'premium_desc': 'Claim your offer now and get unlimited recognition, health check and more',
      'get_it': 'GET IT',

      // Categories
      'crops': 'Crops',
      'crops_desc': 'Basic food that feed the world',
      'vegetables': 'Vegetables',
      'vegetables_desc': 'Essential for a healthy life',
      'fruits': 'Fruits',
      'fruits_desc': "Nature's sweet",
      'legumes': 'Legumes',
      'legumes_desc': 'Power source of plant-based protein',

      // Category Types Screen
      'select_type': 'Select Type',
      'choose_type_desc': 'Choose the type you want to scan',

      // Scan Screens
      'scan_crops': 'Scan Crops',
      'scan_vegetables': 'Scan Vegetables',
      'scan_fruits': 'Scan Fruits',
      'scan_legumes': 'Scan Legumes',
      'position_crops': 'Position crops within the frame',
      'position_vegetables': 'Position vegetables within the frame',
      'position_fruits': 'Position fruits within the frame',
      'position_legumes': 'Position legumes within the frame',
      'scanning_crops': 'Scanning crops...',
      'scanning_vegetables': 'Scanning vegetables...',
      'scanning_fruits': 'Scanning fruits...',
      'scanning_legumes': 'Scanning legumes...',

      // Login & Signup
      'login': 'Login',
      'signup': 'Sign up',
      'email': 'EMAIL',
      'password': 'PASSWORD',
      'full_name': 'FULL NAME',
      'create_password': 'CREATE A PASSWORD',
      'forgot_password': 'Forgot Password?',
      'or_login_with': 'Or Login with',
      'or_signup_with': 'Or Sign Up with',
      'enter_email': 'Enter your email',

      // Forget Password
      'forgot_password_title': 'Forgot password',
      'reset_password_desc': 'Please enter your email to reset the password',
      'your_email': 'Your Email',
      'reset_password': 'RESET PASSWORD',
      'check_email': 'Check your email',
      'reset_link_sent': 'We sent a reset link to contact@dscode...com\nenter 5 digit code that mentioned in the email',
      'set_new_password': 'Set a new password',
      'new_password_desc': 'Create a new password. Ensure it differs from previous ones for security',
      'confirm_password': 'Confirm Password',
      'enter_new_password': 'Enter your new password',
      'reenter_password': 'Re-enter password',
      'update_password': 'UPDATE PASSWORD',

      // Types
      'rice': 'Rice',
      'wheat': 'Wheat',
      'barley': 'Barley',
      'potatoes': 'Potatoes',
      'cucumber': 'Cucumber',
      'tomatoes': 'Tomatoes',
      'banana': 'Banana',
      'apples': 'Apples',
      'bean': 'Bean',

      // Tips
      'rice_tip': 'Rice needs a lot of water - keep soil waterlogged and maintain 5-10cm water level above soil for best growth',
      'wheat_tip': 'Wheat loves full sun - choose a sunny location with at least 6 hours of direct sunlight daily for healthy plants',
      'tomato_tip': 'Tomatoes need good air circulation - space plants 60cm apart and use stakes for support to prevent diseases',

      'apply_tip_msg': 'Apply this tip for the best results!',

      'back': 'Back',

      // Onboarding
      'skip': 'Skip',
      'next': 'Next',
      'get_started': 'Get Started',
      'onboarding_title_1': 'Discover Plants',
      'onboarding_desc_1': 'Scan and identify thousands of plant species with advanced AI technology',
      'onboarding_title_2': 'Expert Care Tips',
      'onboarding_desc_2': 'Get personalized care instructions and seasonal tips for your plants',
      'onboarding_title_3': 'Grow Together',
      'onboarding_desc_3': 'Track your plant health and watch them thrive with our smart monitoring',
    },
    'ar': {
      // Profile Screen
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'english': 'English',
      'arabic': 'العربية',
      'select_language': 'اختر اللغة',
      'app_language': 'لغة التطبيق',
      'account': 'الحساب',
      'notifications': 'الإشعارات',
      'privacy': 'الخصوصية',
      'help': 'المساعدة والدعم',
      'about': 'حول',
      'logout': 'تسجيل الخروج',
      'manage_account': 'إدارة حسابك',
      'notification_prefs': 'تفضيلات الإشعارات',

      // Account Screen
      'edit_profile': 'تعديل الملف الشخصي',
      'change_password': 'تغيير كلمة المرور',
      'change_email': 'تغيير البريد الإلكتروني',
      'delete_account': 'حذف الحساب',
      'delete_account_confirm': 'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'coming_soon': 'قريباً',

      // Notifications Screen
      'notification_settings_desc': 'إدارة تفضيلات الإشعارات',
      'notification_types': 'أنواع الإشعارات',
      'push_notifications': 'إشعارات التطبيق',
      'push_notifications_desc': 'استقبل التنبيهات على جهازك',
      'email_notifications': 'إشعارات البريد',
      'email_notifications_desc': 'احصل على التحديثات عبر البريد',
      'tips_notifications': 'نصائح يومية',
      'tips_notifications_desc': 'استقبل نصائح العناية بالنباتات',
      'scan_reminders': 'تذكير المسح',
      'scan_reminders_desc': 'تذكيرات لفحص نباتاتك',

      // Home Screen
      'home': 'الرئيسية',
      'search_plant': 'ابحث عن نبات',
      'all_feature': 'جميع الممـيزات',
      'seasonal_tips': 'نصائح موسمية',
      'see_all': 'عرض الكل',
      'try_premium': 'جرب المميزات المدفوعة 🌿',
      'premium_desc': 'احصل على عرضك الآن واحصل على تعرف غير محدود وفحص صحي والمزيد',
      'get_it': 'احصل عليه',

      // Categories
      'crops': 'المحاصيل',
      'crops_desc': 'الغذاء الأساسي الذي يغذي العالم',
      'vegetables': 'الخضروات',
      'vegetables_desc': 'ضرورية لحياة صحية',
      'fruits': 'الفواكه',
      'fruits_desc': 'حلوى الطبيعة',
      'legumes': 'البقوليات',
      'legumes_desc': 'مصدر قوي للبروتين النباتي',

      // Category Types Screen
      'select_type': 'اختر النوع',
      'choose_type_desc': 'اختر النوع الذي تريد مسحه',

      // Scan Screens
      'scan_crops': 'مسح المحاصيل',
      'scan_vegetables': 'مسح الخضروات',
      'scan_fruits': 'مسح الفواكه',
      'scan_legumes': 'مسح البقوليات',
      'position_crops': 'ضع المحاصيل داخل الإطار',
      'position_vegetables': 'ضع الخضروات داخل الإطار',
      'position_fruits': 'ضع الفواكه داخل الإطار',
      'position_legumes': 'ضع البقوليات داخل الإطار',
      'scanning_crops': 'جاري مسح المحاصيل...',
      'scanning_vegetables': 'جاري مسح الخضروات...',
      'scanning_fruits': 'جاري مسح الفواكه...',
      'scanning_legumes': 'جاري مسح البقوليات...',

      // Login & Signup
      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'full_name': 'الاسم الكامل',
      'create_password': 'إنشاء كلمة مرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'or_login_with': 'أو تسجيل الدخول بواسطة',
      'or_signup_with': 'أو إنشاء حساب بواسطة',
      'enter_email': 'أدخل بريدك الإلكتروني',

      // Forget Password
      'forgot_password_title': 'نسيت كلمة المرور',
      'reset_password_desc': 'الرجاء إدخال بريدك الإلكتروني لإعادة تعيين كلمة المرور',
      'your_email': 'بريدك الإلكتروني',
      'reset_password': 'إعادة تعيين كلمة المرور',
      'check_email': 'تحقق من بريدك الإلكتروني',
      'reset_link_sent': 'لقد أرسلنا رابط إعادة التعيين إلى contact@dscode...com\nأدخل الرمز المكون من 5 أرقام المذكور في البريد الإلكتروني',
      'set_new_password': 'تعيين كلمة مرور جديدة',
      'new_password_desc': 'إنشاء كلمة مرور جديدة. تأكد من أنها تختلف عن السابقة للأمان',
      'confirm_password': 'تأكيد كلمة المرور',
      'enter_new_password': 'أدخل كلمة المرور الجديدة',
      'reenter_password': 'أعد إدخال كلمة المرور',
      'update_password': 'تحديث كلمة المرور',

      // Types
      'rice': 'الأرز',
      'wheat': 'القمح',
      'barley': 'الشعير',
      'potatoes': 'البطاطس',
      'cucumber': 'الخيار',
      'tomatoes': 'الطماطم',
      'banana': 'الموز',
      'apples': 'التفاح',
      'bean': 'الفول',

      // Tips
      'rice_tip': 'الأرز يحتاج لمياه كثيرة - احتفظ بالتربة مغمورة بالماء بمستوى 5-10 سم فوق التربة للحصول على أفضل نمو',
      'wheat_tip': 'القمح يحب الشمس الكاملة - اختر مكان مشمس مع 6 ساعات على الأقل من ضوء الشمس المباشر يومياً لنباتات صحية',
      'tomato_tip': 'الطماطم تحتاج لتهوية جيدة - اترك مسافة 60 سم بين النباتات واستخدم دعامات للتثبيت لمنع الأمراض',

      'apply_tip_msg': 'طبق هذه النصيحة للحصول على أفضل النتائج!',

      'back': 'رجوع',

      // Onboarding
      'skip': 'تخطي',
      'next': 'التالي',
      'get_started': 'ابدأ الآن',
      'onboarding_title_1': 'اكتشف النباتات',
      'onboarding_desc_1': 'امسح وتعرف على آلاف أنواع النباتات بتقنية الذكاء الاصطناعي المتقدمة',
      'onboarding_title_2': 'نصائح خبراء',
      'onboarding_desc_2': 'احصل على تعليمات رعاية مخصصة ونصائح موسمية لنباتاتك',
      'onboarding_title_3': 'انمو معاً',
      'onboarding_desc_3': 'تتبع صحة نباتاتك وشاهدها تزدهر مع نظام المراقبة الذكي',
    },
  };

  static String translate(String key) {
    String lang = LanguageManager().currentLanguage;
    return _translations[lang]?[key] ?? key;
  }

  static String get(String key) => translate(key);
}