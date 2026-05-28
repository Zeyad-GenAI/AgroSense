import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';

class SeasonsScreen extends StatefulWidget {
  @override
  _SeasonsScreenState createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen>
    with SingleTickerProviderStateMixin {
  final Color mainColor = Color(0xFF29C17E);
  final LanguageManager _languageManager = LanguageManager();
  int _selectedSeason = 0;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> seasonsEn = [
    {
      'name': 'Spring',
      'nameAr': 'الربيع',
      'icon': '🌸',
      'gradient': [Color(0xFF29C17E), Color(0xFF81C784)],
      'bgColor': Color(0xFFE8F5E9),
      'desc': 'Perfect for planting most vegetables and flowers',
      'descAr': 'مثالي لزراعة معظم الخضروات والزهور',
      'plants': [
        {'name': 'Tomatoes', 'nameAr': 'الطماطم', 'icon': '🍅', 'tip': 'Plant after last frost', 'tipAr': 'ازرع بعد آخر صقيع'},
        {'name': 'Cucumber', 'nameAr': 'الخيار', 'icon': '🥒', 'tip': 'Loves warm soil', 'tipAr': 'يحب التربة الدافئة'},
        {'name': 'Lettuce', 'nameAr': 'الخس', 'icon': '🥬', 'tip': 'Cool season crop', 'tipAr': 'محصول موسم بارد'},
        {'name': 'Strawberry', 'nameAr': 'الفراولة', 'icon': '🍓', 'tip': 'Full sun required', 'tipAr': 'يحتاج شمس كاملة'},
        {'name': 'Peas', 'nameAr': 'البازلاء', 'icon': '🌱', 'tip': 'Plant early spring', 'tipAr': 'ازرع في أوائل الربيع'},
        {'name': 'Carrots', 'nameAr': 'الجزر', 'icon': '🥕', 'tip': 'Deep loose soil', 'tipAr': 'تربة عميقة وخفيفة'},
      ],
      'avoid': ['Corn', 'Pumpkin', 'Sweet potato'],
      'avoidAr': ['الذرة', 'القرع', 'البطاطا الحلوة'],
      'conditions': ['Warm days, cool nights', 'Moderate rainfall', 'Good sunlight'],
      'conditionsAr': ['أيام دافئة، ليالٍ باردة', 'أمطار معتدلة', 'ضوء شمس جيد'],
    },
    {
      'name': 'Summer',
      'nameAr': 'الصيف',
      'icon': '☀️',
      'gradient': [Color(0xFFFFCA28), Color(0xFFFF8F00)],
      'bgColor': Color(0xFFFFF8E1),
      'desc': 'Heat-loving crops thrive in summer',
      'descAr': 'المحاصيل المحبة للحرارة تزدهر في الصيف',
      'plants': [
        {'name': 'Watermelon', 'nameAr': 'البطيخ', 'icon': '🍉', 'tip': 'Needs lots of space', 'tipAr': 'يحتاج مساحة كبيرة'},
        {'name': 'Corn', 'nameAr': 'الذرة', 'icon': '🌽', 'tip': 'Plant in blocks', 'tipAr': 'ازرع في مجموعات'},
        {'name': 'Peppers', 'nameAr': 'الفلفل', 'icon': '🌶️', 'tip': 'Water regularly', 'tipAr': 'اسقِ بانتظام'},
        {'name': 'Eggplant', 'nameAr': 'الباذنجان', 'icon': '🍆', 'tip': 'Full sun lover', 'tipAr': 'يحب الشمس الكاملة'},
        {'name': 'Basil', 'nameAr': 'الريحان', 'icon': '🌿', 'tip': 'Pinch flowers off', 'tipAr': 'أزل الأزهار'},
        {'name': 'Okra', 'nameAr': 'البامية', 'icon': '🌱', 'tip': 'Harvest often', 'tipAr': 'احصد بشكل متكرر'},
      ],
      'avoid': ['Lettuce', 'Peas', 'Spinach'],
      'avoidAr': ['الخس', 'البازلاء', 'السبانخ'],
      'conditions': ['Hot sunny days', 'Consistent watering', 'Heat tolerance needed'],
      'conditionsAr': ['أيام حارة ومشمسة', 'ري منتظم', 'مقاومة الحرارة ضرورية'],
    },
    {
      'name': 'Autumn',
      'nameAr': 'الخريف',
      'icon': '🍂',
      'gradient': [Color(0xFFEF6C00), Color(0xFFBF360C)],
      'bgColor': Color(0xFFFBE9E7),
      'desc': 'Root vegetables and brassicas love autumn',
      'descAr': 'الخضروات الجذرية والكرنبيات تحب الخريف',
      'plants': [
        {'name': 'Potatoes', 'nameAr': 'البطاطس', 'icon': '🥔', 'tip': 'Hill up soil', 'tipAr': 'ارفع التربة'},
        {'name': 'Broccoli', 'nameAr': 'البروكلي', 'icon': '🥦', 'tip': 'Cool temps ideal', 'tipAr': 'درجات حرارة باردة مثالية'},
        {'name': 'Garlic', 'nameAr': 'الثوم', 'icon': '🌿', 'tip': 'Plant before winter', 'tipAr': 'ازرع قبل الشتاء'},
        {'name': 'Pumpkin', 'nameAr': 'القرع', 'icon': '🎃', 'tip': 'Start in late summer', 'tipAr': 'ابدأ في أواخر الصيف'},
        {'name': 'Cabbage', 'nameAr': 'الكرنب', 'icon': '🥬', 'tip': 'Frost resistant', 'tipAr': 'مقاوم للصقيع'},
        {'name': 'Turnip', 'nameAr': 'اللفت', 'icon': '🌱', 'tip': 'Fast growing', 'tipAr': 'ينمو بسرعة'},
      ],
      'avoid': ['Tomatoes', 'Cucumber', 'Basil'],
      'avoidAr': ['الطماطم', 'الخيار', 'الريحان'],
      'conditions': ['Mild temperatures', 'Shorter days', 'First frosts approaching'],
      'conditionsAr': ['درجات حرارة معتدلة', 'أيام أقصر', 'اقتراب الصقيع الأول'],
    },
    {
      'name': 'Winter',
      'nameAr': 'الشتاء',
      'icon': '❄️',
      'gradient': [Color(0xFF42A5F5), Color(0xFF1565C0)],
      'bgColor': Color(0xFFE3F2FD),
      'desc': 'Cold-hardy crops and indoor growing season',
      'descAr': 'موسم المحاصيل المقاومة للبرد والزراعة الداخلية',
      'plants': [
        {'name': 'Kale', 'nameAr': 'الكيل', 'icon': '🥬', 'tip': 'Frost improves taste', 'tipAr': 'الصقيع يحسن المذاق'},
        {'name': 'Spinach', 'nameAr': 'السبانخ', 'icon': '🍃', 'tip': 'Cold tolerant', 'tipAr': 'يتحمل البرد'},
        {'name': 'Onion', 'nameAr': 'البصل', 'icon': '🌰', 'tip': 'Plant overwintering sets', 'tipAr': 'ازرع الشتلات الشتوية'},
        {'name': 'Leeks', 'nameAr': 'الكراث', 'icon': '🌱', 'tip': 'Hardy vegetable', 'tipAr': 'خضروات قوية'},
        {'name': 'Microgreens', 'nameAr': 'البراعم الخضراء', 'icon': '🌿', 'tip': 'Grow indoors', 'tipAr': 'ازرع في المنزل'},
        {'name': 'Herbs', 'nameAr': 'الأعشاب', 'icon': '🌱', 'tip': 'Indoor pots work well', 'tipAr': 'أوعية داخلية مناسبة'},
      ],
      'avoid': ['Tomatoes', 'Peppers', 'Corn'],
      'avoidAr': ['الطماطم', 'الفلفل', 'الذرة'],
      'conditions': ['Cold temperatures', 'Short daylight', 'Possible frost/snow'],
      'conditionsAr': ['درجات حرارة باردة', 'نهار قصير', 'احتمال صقيع/ثلج'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _languageManager.removeListener(_onLanguageChanged);
    _animController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  void _selectSeason(int i) {
    setState(() => _selectedSeason = i);
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;
    final season = seasonsEn[_selectedSeason];
    final List<Color> gradient = season['gradient'] as List<Color>;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFF5FAF7),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: gradient[0],
              leading: IconButton(
                icon: Icon(isArabic ? Icons.arrow_forward : Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  isArabic ? 'الفصول الزراعية' : 'Farming Seasons',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Stack(
                    children: [
                      Positioned(right: -30, top: 20,
                          child: Text(season['icon'] as String, style: TextStyle(fontSize: 120))),
                      Positioned(bottom: 55, left: 20,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                              isArabic ? season['nameAr'] as String : season['name'] as String,
                              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              isArabic ? season['descAr'] as String : season['desc'] as String,
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ])),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Season tabs
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(seasonsEn.length, (i) {
                        final s = seasonsEn[i];
                        final sel = _selectedSeason == i;
                        final List<Color> g = s['gradient'] as List<Color>;
                        return GestureDetector(
                          onTap: () => _selectSeason(i),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            padding: EdgeInsets.symmetric(horizontal: sel ? 16 : 10, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: sel ? LinearGradient(colors: g) : null,
                              color: sel ? null : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: sel ? [BoxShadow(color: g[0].withOpacity(0.4), blurRadius: 8, offset: Offset(0, 3))] : [],
                            ),
                            child: Row(children: [
                              Text(s['icon'] as String, style: TextStyle(fontSize: sel ? 18 : 22)),
                              if (sel) ...[
                                SizedBox(width: 6),
                                Text(isArabic ? s['nameAr'] as String : s['name'] as String,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ]),
                          ),
                        );
                      }),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Conditions
                          _buildConditionsCard(season, isArabic, gradient),
                          SizedBox(height: 20),
                          // What to plant
                          Text(
                            isArabic ? '✅ ازرع في هذا الموسم' : '✅ Plant This Season',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A3A2A)),
                          ),
                          SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9),
                            itemCount: (season['plants'] as List).length,
                            itemBuilder: (context, i) {
                              final p = (season['plants'] as List)[i] as Map;
                              return _buildPlantCard(p, isArabic, gradient[0]);
                            },
                          ),
                          SizedBox(height: 20),
                          // Avoid section
                          _buildAvoidCard(season, isArabic),
                        ],
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

  Widget _buildConditionsCard(Map season, bool isArabic, List<Color> gradient) {
    final conditions = isArabic
        ? (season['conditionsAr'] as List<String>)
        : (season['conditions'] as List<String>);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gradient[0].withOpacity(0.12), gradient[1].withOpacity(0.05)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gradient[0].withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isArabic ? '🌡️ الظروف المناخية' : '🌡️ Climate Conditions',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: gradient[0])),
          SizedBox(height: 10),
          ...conditions.map((c) => Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Row(children: [
              Icon(Icons.check_circle, color: gradient[0], size: 16),
              SizedBox(width: 8),
              Text(c, style: TextStyle(fontSize: 13, color: Colors.black87)),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildPlantCard(Map plant, bool isArabic, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
      ),
      padding: EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(plant['icon'] as String, style: TextStyle(fontSize: 28)),
        SizedBox(height: 6),
        Text(isArabic ? plant['nameAr'] as String : plant['name'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        SizedBox(height: 4),
        Text(isArabic ? plant['tipAr'] as String : plant['tip'] as String,
            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, color: Colors.grey[500])),
      ]),
    );
  }

  Widget _buildAvoidCard(Map season, bool isArabic) {
    final avoidList = isArabic
        ? (season['avoidAr'] as List<String>)
        : (season['avoid'] as List<String>);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFEF9A9A), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isArabic ? '❌ تجنب زراعة' : '❌ Avoid Planting',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFEF5350))),
          SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: avoidList.map((name) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFEF9A9A), width: 1),
              ),
              child: Text(name, style: TextStyle(fontSize: 12, color: Color(0xFFEF5350), fontWeight: FontWeight.w600)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}