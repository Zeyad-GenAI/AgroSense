import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_project/localization_service.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with TickerProviderStateMixin {
  final Color mainColor = Color(0xFF29C17E);
  final Color darkColor = Color(0xFF1A3A2A);
  final LanguageManager _languageManager = LanguageManager();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isTyping = false;

  late AnimationController _typingAnimController;

  List<ChatMessage> _messages = [];

  final List<String> _quickRepliesEn = [
    'How to water my plant? 💧',
    'Signs of disease? 🍂',
    'Best fertilizer? 🌱',
    'When to harvest? 🌾',
  ];

  final List<String> _quickRepliesAr = [
    'كيف أسقي نباتي؟ 💧',
    'علامات المرض؟ 🍂',
    'أفضل سماد؟ 🌱',
    'متى أحصد؟ 🌾',
  ];

  @override
  void initState() {
    super.initState();
    _languageManager.addListener(_onLanguageChanged);
    _typingAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..repeat(reverse: true);

    Future.delayed(Duration(milliseconds: 400), () {
      _addBotMessage(
        _languageManager.isArabic
            ? 'مرحباً! 🌿 أنا مساعدك الزراعي الذكي. كيف يمكنني مساعدتك اليوم؟'
            : 'Hello! 🌿 I\'m your smart plant assistant. How can I help you today?',
      );
    });
  }

  @override
  void dispose() {
    _languageManager.removeListener(_onLanguageChanged);
    _controller.dispose();
    _scrollController.dispose();
    _typingAnimController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() => setState(() {});

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false, time: DateTime.now()));
    });
    _scrollToBottom();
  }

  // ══════════════════════════════════════════════════════════════
  //  _sendMessage  —  Gradio 4.x  (خطوتين: POST ثم GET/SSE)
  // ══════════════════════════════════════════════════════════════
  Future<void> _sendMessage(String text) async {

    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text.trim(),
          isUser: true,
          time: DateTime.now(),
        ),
      );

      _isTyping = true;
    });

    _controller.clear();

    _scrollToBottom();

    const String baseUrl =
        'https://zed344-agri-expert.hf.space';

    try {

      // =========================
      // STEP 1
      // =========================

      final postResponse = await http.post(
        Uri.parse('$baseUrl/gradio_api/call/chat_fn'),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "data": [text.trim()]
        }),

      ).timeout(const Duration(seconds: 120));

      print("POST STATUS: ${postResponse.statusCode}");
      print("POST BODY: ${postResponse.body}");

      if (postResponse.statusCode != 200) {
        throw Exception(
            "POST ERROR ${postResponse.statusCode}"
        );
      }

      final postJson = jsonDecode(postResponse.body);

      final String eventId =
      postJson["event_id"];

      // =========================
      // STEP 2
      // =========================

      final getResponse = await http.get(
        Uri.parse(
          '$baseUrl/gradio_api/call/chat_fn/$eventId',
        ),
      ).timeout(const Duration(seconds: 120));

      print("GET STATUS: ${getResponse.statusCode}");
      print("GET BODY: ${getResponse.body}");

      String botReply = '';

      final lines =
      getResponse.body.split('\n');

      for (final line in lines) {

        if (line.startsWith("data:")) {

          final data =
          line.replaceFirst("data:", "").trim();

          if (data.isEmpty) continue;

          try {

            final parsed = jsonDecode(data);

            if (parsed is List &&
                parsed.isNotEmpty) {

              botReply =
                  parsed[0].toString();

              break;
            }

          } catch (_) {}
        }
      }

      if (botReply.isEmpty) {

        if (getResponse.body.contains("event: error")) {

          botReply = _languageManager.isArabic
              ? 'السيرفر شغال لكن حصل خطأ داخلي في الـ AI'
              : 'Server connected but AI returned internal error';

        } else {

          botReply = _languageManager.isArabic
              ? 'لا يوجد رد من السيرفر'
              : 'No response from server';
        }
      }

      if (!mounted) return;

      setState(() {

        _isTyping = false;

        _messages.add(
          ChatMessage(
            text: botReply,
            isUser: false,
            time: DateTime.now(),
          ),
        );
      });

      _scrollToBottom();

    } catch (e) {

      print("FULL ERROR: $e");

      if (!mounted) return;

      setState(() {

        _isTyping = false;

        _messages.add(
          ChatMessage(
            text: _languageManager.isArabic
                ? 'خطأ في الاتصال بالسيرفر'
                : 'Connection error with server',
            isUser: false,
            time: DateTime.now(),
          ),
        );
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ══════════════════════════════════════════════════════════════
  //  build
  // ══════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    bool isArabic = _languageManager.isArabic;
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFF5FAF7),
        appBar: _buildAppBar(isArabic),
        body: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? _buildEmptyState(isArabic)
                  : ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isTyping && index == _messages.length) {
                    return _buildTypingIndicator(isArabic);
                  }
                  return _buildMessageBubble(_messages[index], isArabic);
                },
              ),
            ),
            if (_messages.length <= 1) _buildQuickReplies(isArabic),
            _buildInputBar(isArabic),
          ],
        ),
      ),
    );
  }

  // ── App Bar ─────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(bool isArabic) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          isArabic ? Icons.arrow_forward : Icons.arrow_back,
          color: Colors.black87,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mainColor, Color(0xFF1A9E60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco_rounded, color: Colors.white, size: 22),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'المساعد الزراعي' : 'Plant Assistant',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    isArabic ? 'متصل الآن' : 'Online now',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey.shade200),
      ),
    );
  }

  // ── Empty State ──────────────────────────────────────────────
  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco_rounded, size: 50, color: mainColor),
          ),
          SizedBox(height: 20),
          Text(
            isArabic ? 'اسأل عن نباتاتك!' : 'Ask about your plants!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            isArabic
                ? 'احصل على مساعدة فورية في رعاية نباتاتك'
                : 'Get instant help with plant care',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  // ── Message Bubble ───────────────────────────────────────────
  Widget _buildMessageBubble(ChatMessage msg, bool isArabic) {
    final bool isUser = msg.isUser;
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor, Color(0xFF1A9E60)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.eco_rounded, color: Colors.white, size: 18),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? mainColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: isUser ? Radius.circular(18) : Radius.circular(4),
                  bottomRight: isUser ? Radius.circular(4) : Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 14.5,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: Colors.grey[500], size: 18),
            ),
          ],
        ],
      ),
    );
  }

  // ── Typing Indicator ─────────────────────────────────────────
  Widget _buildTypingIndicator(bool isArabic) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [mainColor, Color(0xFF1A9E60)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco_rounded, color: Colors.white, size: 18),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: _typingAnimController,
                  builder: (_, __) {
                    final delay = i * 0.2;
                    final value =
                    ((_typingAnimController.value - delay).clamp(0.0, 1.0));
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8 + (value * 4),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.5 + value * 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick Replies ────────────────────────────────────────────
  Widget _buildQuickReplies(bool isArabic) {
    final replies = isArabic ? _quickRepliesAr : _quickRepliesEn;
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: replies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _sendMessage(replies[index]),
            child: Container(
              margin: EdgeInsets.only(
                right: isArabic ? 0 : 8,
                left: isArabic ? 8 : 0,
              ),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: mainColor.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                replies[index],
                style: TextStyle(
                  fontSize: 13,
                  color: mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Input Bar ────────────────────────────────────────────────
  Widget _buildInputBar(bool isArabic) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5FAF7),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.grey.shade200, width: 1.5),
              ),
              child: TextField(
                controller: _controller,
                textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: isArabic
                      ? 'اسألني عن نباتاتك...'
                      : 'Ask me about your plants...',
                  hintStyle:
                  TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  prefixIcon:
                  Icon(Icons.eco_outlined, color: mainColor, size: 20),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => _sendMessage(_controller.text),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor, Color(0xFF1A9E60)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}