import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

class FarmingTipsScreen extends StatefulWidget {
  @override
  _FarmingTipsScreenState createState() => _FarmingTipsScreenState();
}

class _FarmingTipsScreenState extends State<FarmingTipsScreen>
    with SingleTickerProviderStateMixin {
  final Color mainColor = Color(0xFF29C17E);
  final Color darkColor = Color(0xFF1A3A2A);
  final LanguageManager _languageManager = LanguageManager();

  int _selectedCategory = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
    _tabController = TabController(length: 4, vsync: this as TickerProvider);
  }

  @override
  void dispose() {
    _languageManager.removeListener(_onLanguageChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  final List<Map<String, dynamic>> categoriesEn = [
    {'label': 'Watering',  'labelAr': 'الري',         'icon': Icons.water_drop_outlined, 'color': 0xFF42A5F5},
    {'label': 'Soil',      'labelAr': 'التربة',        'icon': Icons.landscape_outlined,  'color': 0xFF8D6E63},
    {'label': 'Sunlight',  'labelAr': 'ضوء الشمس',    'icon': Icons.wb_sunny_outlined,   'color': 0xFFFFCA28},
    {'label': 'Pests',     'labelAr': 'الآفات',        'icon': Icons.bug_report_outlined,  'color': 0xFFEF5350},
    {'label': 'Fertilizer','labelAr': 'الأسمدة',       'icon': Icons.science_outlined,    'color': 0xFF66BB6A},
    {'label': 'Harvest',   'labelAr': 'الحصاد',        'icon': Icons.agriculture_outlined,'color': 0xFFFFCA28},
  ];

  final List<List<Map<String, dynamic>>> tipsData = [
    // Watering tips
    [
      {'titleEn': 'Water at the Base', 'titleAr': 'اسقِ عند الجذور',
        'descEn': 'Always water at the base of plants, not on leaves. Wet foliage encourages fungal diseases and wastes water.',
        'descAr': 'اسقِ دائماً عند قاعدة النباتات وليس على الأوراق. الأوراق المبللة تشجع الأمراض الفطرية.',
        'icon': '💧', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF42A5F5},
      {'titleEn': 'Morning is Best', 'titleAr': 'الصباح أفضل وقت',
        'descEn': 'Water early in the morning to allow foliage to dry during the day and reduce risk of diseases.',
        'descAr': 'اسقِ في الصباح الباكر ليجف النبات خلال النهار ويقل خطر الأمراض.',
        'icon': '🌅', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF42A5F5},
      {'titleEn': 'Check Soil Moisture', 'titleAr': 'افحص رطوبة التربة',
        'descEn': 'Stick your finger 2cm into soil. If it feels dry, water. If still moist, wait another day.',
        'descAr': 'ادخل إصبعك 2 سم في التربة. إذا كانت جافة، اسقِ. إذا كانت رطبة، انتظر يوماً آخر.',
        'icon': '🌱', 'level': 'Pro', 'levelAr': 'محترف', 'color': 0xFF42A5F5},
      {'titleEn': 'Drip Irrigation Saves Water', 'titleAr': 'الري بالتنقيط يوفر الماء',
        'descEn': 'Drip irrigation delivers water directly to roots, reducing evaporation by up to 50%.',
        'descAr': 'الري بالتنقيط يوصل الماء مباشرة للجذور ويقلل التبخر بنسبة تصل إلى 50٪.',
        'icon': '💦', 'level': 'Advanced', 'levelAr': 'متقدم', 'color': 0xFF42A5F5},
    ],
    // Soil tips
    [
      {'titleEn': 'Test Your Soil pH', 'titleAr': 'افحص حموضة التربة',
        'descEn': 'Most vegetables prefer pH 6.0-7.0. Test your soil and amend accordingly with lime or sulfur.',
        'descAr': 'معظم الخضروات تفضل pH 6.0-7.0. افحص تربتك وعدّلها بالجير أو الكبريت.',
        'icon': '🧪', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF8D6E63},
      {'titleEn': 'Add Compost Regularly', 'titleAr': 'أضف السماد العضوي بانتظام',
        'descEn': 'Add 2-3 inches of compost each season to improve drainage, fertility, and microbial activity.',
        'descAr': 'أضف 5-7 سم من السماد العضوي كل موسم لتحسين الصرف والخصوبة والنشاط الميكروبي.',
        'icon': '♻️', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF8D6E63},
      {'titleEn': 'Mulching Helps', 'titleAr': 'التغطية تساعد كثيراً',
        'descEn': 'A 3-inch layer of mulch retains moisture, suppresses weeds, and regulates soil temperature.',
        'descAr': 'طبقة من التغطية بسماكة 7 سم تحبس الرطوبة وتقمع الأعشاب وتنظم درجة حرارة التربة.',
        'icon': '🍂', 'level': 'Pro', 'levelAr': 'محترف', 'color': 0xFF8D6E63},
      {'titleEn': 'Don\'t Compact Soil', 'titleAr': 'لا تضغط التربة',
        'descEn': 'Avoid walking on garden beds. Compacted soil restricts root growth and reduces oxygen.',
        'descAr': 'تجنب المشي على أحواض الحديقة. التربة المضغوطة تعيق نمو الجذور وتقلل الأكسجين.',
        'icon': '🚫', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF8D6E63},
    ],
    // Sunlight tips
    [
      {'titleEn': 'Know Sun Requirements', 'titleAr': 'اعرف متطلبات الشمس',
        'descEn': 'Full sun = 6+ hours. Partial sun = 3-6 hours. Shade = less than 3 hours. Match plants to your site.',
        'descAr': 'شمس كاملة = أكثر من 6 ساعات. شمس جزئية = 3-6 ساعات. ظل = أقل من 3 ساعات.',
        'icon': '☀️', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFFFFCA28},
      {'titleEn': 'Observe Sun Patterns', 'titleAr': 'راقب مسارات الشمس',
        'descEn': 'Before planting, observe how sunlight moves across your garden throughout the day.',
        'descAr': 'قبل الزراعة، راقب كيف تتحرك أشعة الشمس عبر حديقتك طوال اليوم.',
        'icon': '🔭', 'level': 'Pro', 'levelAr': 'محترف', 'color': 0xFFFFCA28},
      {'titleEn': 'Shade Cloth in Summer', 'titleAr': 'شبكة الظل في الصيف',
        'descEn': 'Use 30-50% shade cloth to protect sensitive plants during peak summer heat.',
        'descAr': 'استخدم شبكة ظل 30-50٪ لحماية النباتات الحساسة خلال ذروة حرارة الصيف.',
        'icon': '🌂', 'level': 'Advanced', 'levelAr': 'متقدم', 'color': 0xFFFFCA28},
    ],
    // Pest tips
    [
      {'titleEn': 'Inspect Plants Weekly', 'titleAr': 'افحص النباتات أسبوعياً',
        'descEn': 'Regular inspection catches pest problems early before they become serious infestations.',
        'descAr': 'الفحص المنتظم يكتشف مشاكل الآفات مبكراً قبل أن تصبح غزواً خطيراً.',
        'icon': '🔍', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFFEF5350},
      {'titleEn': 'Companion Planting', 'titleAr': 'الزراعة التبادلية',
        'descEn': 'Plant basil near tomatoes to repel aphids. Marigolds deter many common garden pests.',
        'descAr': 'ازرع الريحان بالقرب من الطماطم لطرد حشرة المن. الأقحوان يردع آفات الحدائق الشائعة.',
        'icon': '🌻', 'level': 'Pro', 'levelAr': 'محترف', 'color': 0xFFEF5350},
      {'titleEn': 'Neem Oil Solution', 'titleAr': 'محلول زيت النيم',
        'descEn': 'Mix 2 tsp neem oil + 1 tsp dish soap + 1 liter water. Spray weekly to control most pests.',
        'descAr': 'اخلط 2 ملعقة صغيرة زيت نيم + 1 ملعقة صغيرة صابون + لتر ماء. رش أسبوعياً.',
        'icon': '🧴', 'level': 'Advanced', 'levelAr': 'متقدم', 'color': 0xFFEF5350},
      {'titleEn': 'Remove Affected Leaves', 'titleAr': 'أزل الأوراق المصابة',
        'descEn': 'Immediately remove and dispose of heavily infested leaves to prevent spreading.',
        'descAr': 'أزل وتخلص فوراً من الأوراق الشديدة الإصابة لمنع الانتشار.',
        'icon': '✂️', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFFEF5350},
    ],
    // Fertilizer (shown under index 1 in display but stored at 4)
    [
      {'titleEn': 'N-P-K Explained', 'titleAr': 'شرح N-P-K',
        'descEn': 'N=Nitrogen (leaves), P=Phosphorus (roots), K=Potassium (overall health). Choose based on plant needs.',
        'descAr': 'N=نيتروجين (أوراق)، P=فوسفور (جذور)، K=بوتاسيوم (الصحة العامة). اختر حسب احتياج النبات.',
        'icon': '🧬', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFF66BB6A},
    ],
    // Harvest
    [
      {'titleEn': 'Harvest in the Morning', 'titleAr': 'احصد في الصباح',
        'descEn': 'Morning harvest gives you the freshest, most flavorful produce as plants are fully hydrated.',
        'descAr': 'الحصاد الصباحي يمنحك أطعمة أكثر نضارة ونكهة حيث تكون النباتات ممتلئة بالماء.',
        'icon': '🌄', 'level': 'Basic', 'levelAr': 'أساسي', 'color': 0xFFAB47BC},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;
    final tips = _selectedCategory < tipsData.length ? tipsData[_selectedCategory] : tipsData[0];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFF5FAF7),
        appBar: AppBar(
          backgroundColor: darkColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(isArabic ? Icons.arrow_forward : Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isArabic ? 'الإرشادات والتوصيات' : 'Tips & Recommendations',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Category row
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(categoriesEn.length, (i) {
                    final cat = categoriesEn[i];
                    final col = Color(cat['color'] as int);
                    final sel = _selectedCategory == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = i),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: sel ? col.withOpacity(0.12) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: sel ? col : Colors.transparent, width: 1.5),
                        ),
                        child: Row(children: [
                          Icon(cat['icon'] as IconData, color: sel ? col : Colors.grey[500], size: 18),
                          SizedBox(width: 6),
                          Text(
                            isArabic ? cat['labelAr'] as String : cat['label'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: sel ? FontWeight.bold : FontWeight.w500,
                              color: sel ? col : Colors.grey[600],
                            ),
                          ),
                        ]),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            // Tips list
            Expanded(
              child: tips.isEmpty
                  ? _buildComingSoon(isArabic)
                  : ListView.separated(
                padding: EdgeInsets.all(20),
                itemCount: tips.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 14),
                itemBuilder: (context, i) {
                  if (i == 0) return _buildFeaturedBanner(isArabic);
                  return _buildTipCard(tips[i - 1], isArabic);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBanner(bool isArabic) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainColor, Color(0xFF1A9E60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: mainColor.withOpacity(0.35), blurRadius: 14, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          Text('💡', style: TextStyle(fontSize: 40)),
          SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                isArabic ? 'نصائح الخبراء' : 'Expert Tips',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                isArabic
                    ? 'توصيات مجربة من خبراء الزراعة'
                    : 'Proven recommendations from farming experts',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map tip, bool isArabic) {
    final col = Color(tip['color'] as int);
    final level = isArabic ? tip['levelAr'] as String : tip['level'] as String;
    Color levelColor;
    switch (tip['level']) {
      case 'Pro': levelColor = Colors.orange; break;
      case 'Advanced': levelColor = Color(0xFFAB47BC); break;
      default: levelColor = mainColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: col.withOpacity(0.07),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(children: [
              Text(tip['icon'] as String, style: TextStyle(fontSize: 26)),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  isArabic ? tip['titleAr'] as String : tip['titleEn'] as String,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1A3A2A)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: levelColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(level, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: levelColor)),
              ),
            ]),
          ),
          // Body
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              isArabic ? tip['descAr'] as String : tip['descEn'] as String,
              style: TextStyle(fontSize: 13.5, color: Colors.grey[700], height: 1.5),
            ),
          ),
          // Bottom action
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1)),
            ),
            child: Row(
              children: [
                Icon(Icons.bookmark_border, color: Colors.grey[400], size: 20),
                SizedBox(width: 6),
                Text(isArabic ? 'احفظ النصيحة' : 'Save tip',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                Spacer(),
                Icon(Icons.share_outlined, color: Colors.grey[400], size: 20),
                SizedBox(width: 6),
                Text(isArabic ? 'شارك' : 'Share',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(bool isArabic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🌱', style: TextStyle(fontSize: 60)),
          SizedBox(height: 16),
          Text(
            isArabic ? 'قريباً...' : 'Coming Soon...',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
          ),
          SizedBox(height: 8),
          Text(
            isArabic ? 'نصائح هذا القسم قيد الإعداد' : 'Tips for this section are being prepared',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

mixin _TickerProviderMixin on State<FarmingTipsScreen> implements TickerProvider {}