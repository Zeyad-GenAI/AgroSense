import 'package:flutter/material.dart';
import 'package:plant_project/localization_service.dart';
import 'package:plant_project/screens/home_screen.dart';
import 'package:plant_project/new screens/general_camera_screen.dart';

class PlantPhotoUploadScreen extends StatefulWidget {
  @override
  _PlantPhotoUploadScreenState createState() => _PlantPhotoUploadScreenState();
}

class _PlantPhotoUploadScreenState extends State<PlantPhotoUploadScreen>
    with SingleTickerProviderStateMixin {
  final Color mainColor = Color(0xFF29C17E);
  final Color darkColor = Color(0xFF1A3A2A);
  final LanguageManager _languageManager = LanguageManager();

  bool _hasImage = false;
  String? _note;
  final TextEditingController _noteController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _languageManager.removeListener(_onLanguageChanged);
    _noteController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  void _onAnalyze() {
    if (!_hasImage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_languageManager.isArabic
            ? 'من فضلك أضف صورة أولاً'
            : 'Please add a photo first'),
        backgroundColor: mainColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFF5FAF7),
        appBar: _buildAppBar(isArabic),
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  _buildHeaderCard(isArabic),
                  SizedBox(height: 24),

                  // Upload area
                  _buildUploadArea(isArabic),
                  SizedBox(height: 20),

                  // Or divider
                  _buildOrDivider(isArabic),
                  SizedBox(height: 20),

                  // Camera button
                  _buildCameraButton(isArabic),
                  SizedBox(height: 28),

                  // Note section
                  _buildNoteSection(isArabic),
                  SizedBox(height: 32),

                  // Analyze button
                  _buildAnalyzeButton(isArabic),
                  SizedBox(height: 16),

                  // Skip button
                  _buildSkipButton(isArabic),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isArabic) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(isArabic ? Icons.arrow_forward : Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        isArabic ? 'تحليل النبات' : 'Plant Analysis',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey.shade200),
      ),
    );
  }

  Widget _buildHeaderCard(bool isArabic) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkColor, mainColor.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: mainColor.withOpacity(0.3), blurRadius: 14, offset: Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Text('📸', style: TextStyle(fontSize: 36)),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'أضف صورة نباتك' : 'Add Your Plant Photo',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  isArabic
                      ? 'سنحلل الصورة ونعطيك تقريراً شاملاً'
                      : 'We\'ll analyze it and give you a full report',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea(bool isArabic) {
    return GestureDetector(
      onTap: () {
        setState(() => _hasImage = !_hasImage);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: _hasImage ? mainColor.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hasImage ? mainColor : Colors.grey.shade300,
            width: 2,
            // Dashed effect via custom painter below
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: Offset(0, 3)),
          ],
        ),
        child: _hasImage ? _buildImagePreview(isArabic) : _buildUploadPlaceholder(isArabic),
      ),
    );
  }

  Widget _buildUploadPlaceholder(bool isArabic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: mainColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.cloud_upload_outlined, color: mainColor, size: 32),
        ),
        SizedBox(height: 10),
        Text(
          isArabic ? 'ارفع صورة' : 'Upload Photo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 4),
        Text(
          isArabic ? 'أو' : 'or',
          style: TextStyle(fontSize: 13, color: Colors.grey[400]),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isArabic ? 'اختر من المعرض' : 'Browse Gallery',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 10),
        Text(
          isArabic ? 'PNG، JPG، JPEG فقط' : 'PNG, JPG, JPEG only',
          style: TextStyle(fontSize: 11, color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildImagePreview(bool isArabic) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, color: mainColor, size: 50),
              SizedBox(height: 10),
              Text(
                isArabic ? 'تم إضافة الصورة ✓' : 'Photo Added ✓',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: mainColor),
              ),
              SizedBox(height: 6),
              Text(
                isArabic ? 'اضغط لتغييرها' : 'Tap to change',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: isArabic ? null : 10,
          left: isArabic ? 10 : null,
          child: GestureDetector(
            onTap: () => setState(() => _hasImage = false),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
              child: Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider(bool isArabic) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            isArabic ? 'أو التقط صورة' : 'or take a photo',
            style: TextStyle(fontSize: 13, color: Colors.grey[400], fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _buildCameraButton(bool isArabic) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GeneralCameraScreen())),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: mainColor.withOpacity(0.4), width: 1.5),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_rounded, color: mainColor, size: 22),
            SizedBox(width: 10),
            Text(
              isArabic ? 'التقط صورة بالكاميرا' : 'Take Photo with Camera',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: mainColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteSection(bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'ملاحظات (اختياري)' : 'Add Note (Optional)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: TextField(
            controller: _noteController,
            maxLines: 3,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: InputDecoration(
              hintText: isArabic
                  ? 'اكتب ملاحظاتك هنا... مثلاً: أوراق صفراء، تربة جافة'
                  : 'Write notes here... e.g. yellow leaves, dry soil',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Icon(Icons.notes_rounded, color: Colors.grey[400], size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton(bool isArabic) {
    return GestureDetector(
      onTap: _onAnalyze,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [mainColor, Color(0xFF1A9E60)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: mainColor.withOpacity(0.45), blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              isArabic ? 'تحليل النبات الآن' : 'Analyze Plant Now',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(bool isArabic) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        ),
        child: Text(
          isArabic ? 'تخطي الآن' : 'Skip for now',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}