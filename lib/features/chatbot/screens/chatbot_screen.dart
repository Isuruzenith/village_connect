import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// AI Chatbot screen with multilingual support (English, Sinhala, Tamil).
/// Provides citizens with instant help for common questions about
/// government services, document applications, and community info.
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _inputFocusNode = FocusNode();

  // Current language: 'en', 'si', 'ta'
  String _currentLang = 'en';

  // Chat messages
  final List<_ChatMessage> _messages = [];

  // Whether the bot is currently "typing"
  bool _isBotTyping = false;

  late AnimationController _typingAnimController;

  // Localized strings
  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'title': 'Village Assistant',
      'subtitle': 'How can I help you today?',
      'hint': 'Type your message...',
      'welcome':
          'Hello! I\'m your Village Connect Assistant. I can help you with document applications, tracking requests, community information, and more. How can I assist you today?',
      'lang_label': 'EN',
    },
    'si': {
      'title': 'ගම්මාන සහායක',
      'subtitle': 'අද මට ඔබට කෙසේ උදව් කළ හැකිද?',
      'hint': 'ඔබේ පණිවිඩය ටයිප් කරන්න...',
      'welcome':
          'ආයුබෝවන්! මම ඔබේ Village Connect සහායකයා. ලේඛන අයදුම්පත්, ඉල්ලීම් නිරීක්ෂණය, ප්‍රජා තොරතුරු සහ තවත් බොහෝ දේ සඳහා මට ඔබට උදව් කළ හැකිය. අද මට ඔබට කෙසේ සහාය විය හැකිද?',
      'lang_label': 'සිං',
    },
    'ta': {
      'title': 'கிராம உதவியாளர்',
      'subtitle': 'இன்று நான் உங்களுக்கு எப்படி உதவ முடியும்?',
      'hint': 'உங்கள் செய்தியை தட்டச்சு செய்யவும்...',
      'welcome':
          'வணக்கம்! நான் உங்கள் Village Connect உதவியாளர். ஆவண விண்ணப்பங்கள், கோரிக்கை கண்காணிப்பு, சமூக தகவல்கள் மற்றும் பலவற்றில் நான் உங்களுக்கு உதவ முடியும். இன்று நான் உங்களுக்கு எப்படி உதவ முடியும்?',
      'lang_label': 'தமி',
    },
  };

  // Quick suggestions per language
  static const Map<String, List<String>> _quickSuggestions = {
    'en': [
      'How to apply for a certificate?',
      'Track my application',
      'Office hours & contact',
      'Report a community issue',
    ],
    'si': [
      'සහතිකයක් සඳහා අයදුම් කරන්නේ කෙසේද?',
      'මගේ අයදුම්පත සොයන්න',
      'කාර්යාල වේලාවන් සහ සම්බන්ධතා',
      'ප්‍රජා ගැටලුවක් වාර්තා කරන්න',
    ],
    'ta': [
      'சான்றிதழுக்கு எவ்வாறு விண்ணப்பிப்பது?',
      'எனது விண்ணப்பத்தை கண்காணிக்க',
      'அலுவலக நேரம் & தொடர்பு',
      'சமூக பிரச்சினையை புகாரளிக்க',
    ],
  };

  // Bot responses per language (keyed by pattern)
  static const Map<String, Map<String, String>> _botResponses = {
    'en': {
      'certificate':
          'To apply for a certificate:\n\n1. Go to Home > "Apply for Document"\n2. Select the certificate type (Character, Residence, Income, etc.)\n3. Fill in your details (Name, NIC, Address, Reason)\n4. Upload required documents (NIC copy)\n5. Review and submit\n\nYou\'ll receive a tracking ID to monitor your application. Processing typically takes 3-5 working days.',
      'track':
          'To track your application:\n\n1. Go to "My Requests" from the bottom navigation\n2. You\'ll see all your submitted requests with status indicators\n3. Tap on any request to see detailed status history\n\nStatus types: Pending → In Review → Approved/Rejected\n\nYou\'ll also receive notifications when your status changes.',
      'office':
          'GN Office Contact Information:\n\n📞 Phone: +94 11 234 5678\n🕐 Hours: Mon-Fri, 8:30 AM - 4:30 PM\n📍 Address: GN Office, Temple Road, Kaduwela\n📧 Email: gn.kaduwela@gov.lk\n\nThe office is closed on weekends and public holidays.',
      'report':
          'To report a community issue:\n\n1. Go to Home > "Report a Problem"\n2. Select the issue category (Road, Water, Electricity, etc.)\n3. Describe the problem\n4. Optionally attach a photo\n5. Pin the location on the map\n\nYour report will be forwarded to the relevant GN Officer for action. You\'ll receive a tracking ID to monitor progress.',
      'default':
          'I can help you with:\n\n• Applying for documents & certificates\n• Tracking your applications\n• GN Office contact & hours\n• Reporting community issues\n• Understanding notice board updates\n\nPlease ask me about any of these topics, or type your question.',
    },
    'si': {
      'certificate':
          'සහතිකයක් සඳහා අයදුම් කිරීමට:\n\n1. මුල් පිටුව > "ලේඛනයක් සඳහා අයදුම් කරන්න" වෙත යන්න\n2. සහතික වර්ගය තෝරන්න (චරිත, පදිංචි, ආදායම්, ආදිය)\n3. ඔබේ විස්තර පුරවන්n (නම, ජා.හැ.අ., ලිපිනය, හේතුව)\n4. අවශ්‍ය ලේඛන උඩුගත කරන්න (ජා.හැ.අ. පිටපත)\n5. සමාලෝචනය කර ඉදිරිපත් කරන්න\n\nඔබට ඔබේ අයදුම්පත නිරීක්ෂණය කිරීමට හඳුනාගැනීම් අංකයක් ලැබේ. සැකසීම සාමාන්‍යයෙන් වැඩ කරන දින 3-5ක් ගනී.',
      'track':
          'ඔබේ අයදුම්පත සොයා බැලීමට:\n\n1. පහළ සංචාලනයෙන් "මගේ ඉල්ලීම්" වෙත යන්න\n2. ඔබේ සියලුම ඉදිරිපත් කළ ඉල්ලීම් තත්ව දර්ශක සමඟ පෙනේ\n3. සවිස්තරාත්මක තත්ව ඉතිහාසය බැලීමට ඕනෑම ඉල්ලීමක් මත තට්ටු කරන්න\n\nතත්ව වර්ග: අපේක්ෂිත → සමාලෝචනයේ → අනුමත/ප්‍රතික්ෂේප\n\nඔබේ තත්වය වෙනස් වූ විට ඔබට දැනුම්දීම් ද ලැබේ.',
      'office':
          'ග්‍රාම නිලධාරී කාර්යාල සම්බන්ධතා:\n\n📞 දුරකථනය: +94 11 234 5678\n🕐 වේලාවන්: සඳුදා-සිකුරාදා, පෙ.ව. 8:30 - ප.ව. 4:30\n📍 ලිපිනය: ග්‍රාම නිලධාරී කාර්යාලය, පන්සල පාර, කඩුවෙල\n📧 විද්‍යුත් තැපෑල: gn.kaduwela@gov.lk\n\nසති අන්ත සහ රජයේ නිවාඩු දිනවල කාර්යාලය වසා ඇත.',
      'report':
          'ප්‍රජා ගැටලුවක් වාර්තා කිරීමට:\n\n1. මුල් පිටුව > "ගැටලුවක් වාර්තා කරන්න" වෙත යන්න\n2. ගැටලු කාණ්ඩය තෝරන්න (මාර්ග, ජලය, විදුලිය, ආදිය)\n3. ගැටලුව විස්තර කරන්න\n4. විකල්ප ලෙස ඡායාරූපයක් ඇමිණ්ම\n5. සිතියමේ ස්ථානය සලකුණු කරන්න\n\nඔබේ වාර්තාව අදාළ ග්‍රාම නිලධාරී වෙත යොමු කෙරේ.',
      'default':
          'මට ඔබට උදව් කළ හැක්කේ:\n\n• ලේඛන සහ සහතික සඳහා අයදුම් කිරීම\n• ඔබේ අයදුම්පත් නිරීක්ෂණය\n• ග්‍රාම නිලධාරී කාර්යාල සම්බන්ධතා\n• ප්‍රජා ගැටලු වාර්තා කිරීම\n• දැනුම්දීම් පුවරු යාවත්කාලීන\n\nකරුණාකර මෙම මාතෘකා ගැන මගෙන් අසන්න.',
    },
    'ta': {
      'certificate':
          'சான்றிதழுக்கு விண்ணப்பிக்க:\n\n1. முகப்பு > "ஆவணத்திற்கு விண்ணப்பிக்கவும்" என்பதற்கு செல்லவும்\n2. சான்றிதழ் வகையை தேர்ந்தெடுக்கவும் (குணாதிசயம், வதிவிடம், வருமானம், போன்றவை)\n3. உங்கள் விவரங்களை நிரப்பவும் (பெயர், தே.அ.அ., முகவரி, காரணம்)\n4. தேவையான ஆவணங்களை பதிவேற்றவும் (தே.அ.அ. நகல்)\n5. மதிப்பாய்வு செய்து சமர்ப்பிக்கவும்\n\nஉங்கள் விண்ணப்பத்தை கண்காணிக்க ஒரு கண்காணிப்பு எண் கிடைக்கும். செயலாக்கம் பொதுவாக 3-5 வேலை நாட்கள் ஆகும்.',
      'track':
          'உங்கள் விண்ணப்பத்தை கண்காணிக்க:\n\n1. கீழ் வழிசெலுத்தலில் "எனது கோரிக்கைகள்" என்பதற்கு செல்லவும்\n2. நிலை குறிகாட்டிகளுடன் சமர்ப்பிக்கப்பட்ட அனைத்து கோரிக்கைகளையும் காண்பீர்கள்\n3. விரிவான நிலை வரலாற்றைக் காண எந்த கோரிக்கையையும் தட்டவும்\n\nநிலை வகைகள்: நிலுவையில் → மதிப்பாய்வில் → அங்கீகரிக்கப்பட்டது/நிராகரிக்கப்பட்டது',
      'office':
          'கிராம அலுவலகர் தொடர்பு தகவல்:\n\n📞 தொலைபேசி: +94 11 234 5678\n🕐 நேரம்: திங்கள்-வெள்ளி, காலை 8:30 - மாலை 4:30\n📍 முகவரி: கிராம அலுவலகம், கோவில் வீதி, கடுவெல\n📧 மின்னஞ்சல்: gn.kaduwela@gov.lk\n\nவார இறுதி மற்றும் அரசு விடுமுறை நாட்களில் அலுவலகம் மூடப்பட்டிருக்கும்.',
      'report':
          'சமூக பிரச்சினையை புகாரளிக்க:\n\n1. முகப்பு > "பிரச்சினையை புகாரளிக்கவும்" என்பதற்கு செல்லவும்\n2. பிரச்சினை வகையை தேர்ந்தெடுக்கவும் (சாலை, நீர், மின்சாரம், போன்றவை)\n3. பிரச்சினையை விவரிக்கவும்\n4. விருப்பமாக புகைப்படம் இணைக்கவும்\n5. வரைபடத்தில் இடத்தை குறிக்கவும்\n\nஉங்கள் புகார் சம்பந்தப்பட்ட கிராம அலுவலருக்கு அனுப்பப்படும்.',
      'default':
          'நான் உங்களுக்கு உதவ முடியும்:\n\n• ஆவணங்கள் & சான்றிதழ்களுக்கு விண்ணப்பித்தல்\n• உங்கள் விண்ணப்பங்களை கண்காணித்தல்\n• கிராம அலுவலக தொடர்பு & நேரம்\n• சமூக பிரச்சினைகளை புகாரளித்தல்\n• அறிவிப்பு பலகை புதுப்பிப்புகள்\n\nதயவுசெய்து இந்த தலைப்புகளில் ஏதேனும் கேளுங்கள்.',
    },
  };

  @override
  void initState() {
    super.initState();

    _typingAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    // Add welcome message
    _messages.add(_ChatMessage(
      text: _strings[_currentLang]!['welcome']!,
      isBot: true,
      timestamp: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _inputFocusNode.dispose();
    _typingAnimController.dispose();
    super.dispose();
  }

  void _switchLanguage(String lang) {
    if (lang == _currentLang) return;
    setState(() {
      _currentLang = lang;
      _messages.clear();
      _messages.add(_ChatMessage(
        text: _strings[_currentLang]!['welcome']!,
        isBot: true,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: text.trim(),
        isBot: false,
        timestamp: DateTime.now(),
      ));
      _messageController.clear();
      _isBotTyping = true;
    });

    _scrollToBottom();

    // Simulate bot response delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _isBotTyping = false;
        _messages.add(_ChatMessage(
          text: _getBotResponse(text.trim()),
          isBot: true,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  String _getBotResponse(String input) {
    final lower = input.toLowerCase();
    final responses = _botResponses[_currentLang]!;

    // Pattern matching for known topics
    if (_matchesCertificate(lower)) {
      return responses['certificate']!;
    } else if (_matchesTrack(lower)) {
      return responses['track']!;
    } else if (_matchesOffice(lower)) {
      return responses['office']!;
    } else if (_matchesReport(lower)) {
      return responses['report']!;
    }
    return responses['default']!;
  }

  bool _matchesCertificate(String input) {
    const keywords = [
      'certificate', 'apply', 'document', 'application', 'submit',
      'සහතික', 'අයදුම්', 'ලේඛන',
      'சான்றிதழ்', 'விண்ணப்ப', 'ஆவண',
    ];
    return keywords.any((k) => input.contains(k));
  }

  bool _matchesTrack(String input) {
    const keywords = [
      'track', 'status', 'request', 'check', 'progress',
      'සොයන්න', 'නිරීක්ෂණ', 'තත්ව',
      'கண்காணி', 'நிலை', 'கோரிக்கை',
    ];
    return keywords.any((k) => input.contains(k));
  }

  bool _matchesOffice(String input) {
    const keywords = [
      'office', 'hours', 'contact', 'phone', 'address', 'email',
      'කාර්යාල', 'සම්බන්ධ', 'දුරකථන',
      'அலுவலக', 'தொடர்பு', 'தொலைபேசி',
    ];
    return keywords.any((k) => input.contains(k));
  }

  bool _matchesReport(String input) {
    const keywords = [
      'report', 'issue', 'problem', 'complaint',
      'වාර්තා', 'ගැටලු', 'ප්‍රශ්න',
      'புகார்', 'பிரச்சினை', 'பிரச்சனை',
    ];
    return keywords.any((k) => input.contains(k));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildLanguageSelector(),
            Expanded(child: _buildMessageList()),
            if (_messages.length <= 1) _buildQuickSuggestions(),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.textPrimary,
            iconSize: 24,
          ),
          const SizedBox(width: 4),
          // Bot avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _strings[_currentLang]!['title']!,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: AppColors.secondarySurface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Language: ',
            style: AppTextStyles.small.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          _buildLangChip('en', 'English'),
          const SizedBox(width: 8),
          _buildLangChip('si', 'සිංහල'),
          const SizedBox(width: 8),
          _buildLangChip('ta', 'தமிழ்'),
        ],
      ),
    );
  }

  Widget _buildLangChip(String lang, String label) {
    final isSelected = _currentLang == lang;
    return GestureDetector(
      onTap: () => _switchLanguage(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.small.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: _messages.length + (_isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isBotTyping) {
          return _buildTypingIndicator();
        }
        return _buildMessageBubble(_messages[index]);
      },
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    final isBot = message.isBot;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isBot) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isBot ? AppColors.card : AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isBot ? 4 : 16),
                  bottomRight: Radius.circular(isBot ? 16 : 4),
                ),
                border: isBot
                    ? Border.all(color: AppColors.border, width: 1)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: AppTextStyles.caption.copyWith(
                  color: isBot ? AppColors.textPrimary : Colors.white,
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (!isBot) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.secondarySurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: FadeTransition(
              opacity: _typingAnimController,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  return Padding(
                    padding: EdgeInsets.only(left: i > 0 ? 4 : 0),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.textMuted.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSuggestions() {
    final suggestions = _quickSuggestions[_currentLang]!;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: suggestions.map((s) {
          return GestureDetector(
            onTap: () => _sendMessage(s),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                s,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: const Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _inputFocusNode,
                  style: AppTextStyles.body.copyWith(fontSize: 15),
                  textInputAction: TextInputAction.send,
                  onSubmitted: _sendMessage,
                  decoration: InputDecoration(
                    hintText: _strings[_currentLang]!['hint']!,
                    hintStyle: AppTextStyles.body.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _sendMessage(_messageController.text),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;
  final DateTime timestamp;

  const _ChatMessage({
    required this.text,
    required this.isBot,
    required this.timestamp,
  });
}
