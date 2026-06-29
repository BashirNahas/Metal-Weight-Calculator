import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('ar'));
  }

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  String _t(String key) =>
      _strings[locale.languageCode]?[key] ??
      _strings['en']?[key] ??
      key;

  // App
  String get appName => _t('appName');
  String get poweredBy => _t('poweredBy');
  String get companyName => _t('companyName');

  // Navigation
  String get calculator => _t('calculator');
  String get prices => _t('prices');
  String get history => _t('history');
  String get settings => _t('settings');

  // Calculator
  String get selectMetal => _t('selectMetal');
  String get copper => _t('copper');
  String get aluminum => _t('aluminum');
  String get iron => _t('iron');
  String get selectShape => _t('selectShape');
  String get rectangle => _t('rectangle');
  String get circle => _t('circle');
  String get enterMeasurements => _t('enterMeasurements');
  String get length => _t('length');
  String get width => _t('width');
  String get diameter => _t('diameter');
  String get thickness => _t('thickness');
  String get calculateWeight => _t('calculateWeight');
  String get required => _t('required');
  String get fillAllFields => _t('fillAllFields');
  String get positiveNumber => _t('positiveNumber');

  // Result dialog
  String get result => _t('result');
  String get weight => _t('weight');
  String get kg => _t('kg');
  String get copyResult => _t('copyResult');
  String get shareResult => _t('shareResult');
  String get saveFavorite => _t('saveFavorite');
  String get removeFavorite => _t('removeFavorite');
  String get calculateAgain => _t('calculateAgain');
  String get close => _t('close');
  String get copied => _t('copied');
  String get savedToFavorites => _t('savedToFavorites');
  String get removedFromFavorites => _t('removedFromFavorites');

  // Reset
  String get reset => _t('reset');
  String get confirmReset => _t('confirmReset');
  String get resetConfirmMessage => _t('resetConfirmMessage');
  String get cancel => _t('cancel');
  String get confirm => _t('confirm');

  // History
  String get noHistory => _t('noHistory');
  String get clearAll => _t('clearAll');
  String get confirmClearHistory => _t('confirmClearHistory');
  String get clearHistoryMessage => _t('clearHistoryMessage');
  String get favoritesOnly => _t('favoritesOnly');
  String get allCalculations => _t('allCalculations');
  String get noFavorites => _t('noFavorites');

  // Market prices
  String get marketPrices => _t('marketPrices');
  String get liveMarketPrices => _t('liveMarketPrices');
  String get lastUpdated => _t('lastUpdated');
  String get perTonne => _t('perTonne');
  String get perKg => _t('perKg');
  String get loading => _t('loading');
  String get failedToLoad => _t('failedToLoad');
  String get retry => _t('retry');
  String get refresh => _t('refresh');
  String get pullToRefresh => _t('pullToRefresh');

  // Settings
  String get theme => _t('theme');
  String get light => _t('light');
  String get dark => _t('dark');
  String get system => _t('system');
  String get language => _t('language');
  String get english => _t('english');
  String get arabic => _t('arabic');
  String get about => _t('about');
  String get version => _t('version');
  String get developer => _t('developer');
  String get privacyPolicy => _t('privacyPolicy');
  String get contactDeveloper => _t('contactDeveloper');
  String get rateApp => _t('rateApp');
  String get shareApp => _t('shareApp');
  String get appearance => _t('appearance');
  String get support => _t('support');
  String get credits => _t('credits');

  // Metal names (market)
  String get gold => _t('gold');
  String get silver => _t('silver');
  String get zinc => _t('zinc');
  String get nickel => _t('nickel');
  String get lead => _t('lead');
  String get tin => _t('tin');
  String get platinum => _t('platinum');
  String get palladium => _t('palladium');

  // Helper
  String metalName(String key) =>
      _t('metal_$key') != 'metal_$key' ? _t('metal_$key') : key;

  static const Map<String, Map<String, String>> _strings = {
    'ar': {
      'appName': 'حساب وزن المعادن',
      'poweredBy': 'مدعوم من',
      'companyName': 'Synaptix',
      'calculator': 'الحاسبة',
      'prices': 'الأسعار',
      'history': 'السجل',
      'settings': 'الإعدادات',
      'selectMetal': 'اختر المعدن',
      'copper': 'نحاس',
      'aluminum': 'ألومنيوم',
      'iron': 'حديد',
      'selectShape': 'اختر الشكل',
      'rectangle': 'مستطيلة',
      'circle': 'مدورة',
      'enterMeasurements': 'أدخل القياسات',
      'length': 'الطول (سم)',
      'width': 'العرض (سم)',
      'diameter': 'القطر (سم)',
      'thickness': 'السماكة (مم)',
      'calculateWeight': 'احسب الوزن',
      'required': 'مطلوب',
      'fillAllFields': 'يرجى ملء جميع الحقول المطلوبة',
      'positiveNumber': 'أدخل رقماً موجباً',
      'result': 'نتيجة الحساب',
      'weight': 'الوزن',
      'kg': 'كغ',
      'copyResult': 'نسخ',
      'shareResult': 'مشاركة',
      'saveFavorite': 'حفظ في المفضلة',
      'removeFavorite': 'إزالة من المفضلة',
      'calculateAgain': 'حساب جديد',
      'close': 'إغلاق',
      'copied': 'تم النسخ إلى الحافظة',
      'savedToFavorites': 'تم الحفظ في المفضلة',
      'removedFromFavorites': 'تم الإزالة من المفضلة',
      'reset': 'إعادة ضبط',
      'confirmReset': 'تأكيد الإعادة',
      'resetConfirmMessage': 'هل تريد إعادة ضبط جميع الحقول؟',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'noHistory': 'لا توجد حسابات بعد',
      'clearAll': 'مسح الكل',
      'confirmClearHistory': 'مسح السجل',
      'clearHistoryMessage': 'هل تريد مسح جميع سجلات الحسابات؟',
      'favoritesOnly': 'المفضلة فقط',
      'allCalculations': 'جميع الحسابات',
      'noFavorites': 'لا توجد مفضلات',
      'marketPrices': 'أسعار المعادن',
      'liveMarketPrices': 'أسعار السوق الحية',
      'lastUpdated': 'آخر تحديث',
      'perTonne': 'لكل طن',
      'perKg': 'لكل كغ',
      'loading': 'جاري التحميل...',
      'failedToLoad': 'فشل تحميل الأسعار',
      'retry': 'إعادة المحاولة',
      'refresh': 'تحديث',
      'pullToRefresh': 'اسحب للتحديث',
      'theme': 'المظهر',
      'light': 'فاتح',
      'dark': 'داكن',
      'system': 'تلقائي',
      'language': 'اللغة',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'about': 'حول التطبيق',
      'version': 'الإصدار',
      'developer': 'المطور',
      'privacyPolicy': 'سياسة الخصوصية',
      'contactDeveloper': 'تواصل مع المطور',
      'rateApp': 'قيّم التطبيق',
      'shareApp': 'شارك التطبيق',
      'appearance': 'المظهر والشكل',
      'support': 'الدعم',
      'credits': 'الاعتمادات',
      'gold': 'ذهب',
      'silver': 'فضة',
      'zinc': 'زنك',
      'nickel': 'نيكل',
      'lead': 'رصاص',
      'tin': 'قصدير',
      'platinum': 'بلاتين',
      'palladium': 'بلاديوم',
      'metal_copper': 'نحاس',
      'metal_aluminum': 'ألومنيوم',
      'metal_aluminium': 'ألومنيوم',
      'metal_iron': 'حديد',
      'metal_iron ore': 'خام الحديد',
      'metal_zinc': 'زنك',
      'metal_nickel': 'نيكل',
      'metal_gold': 'ذهب',
      'metal_silver': 'فضة',
      'metal_lead': 'رصاص',
      'metal_tin': 'قصدير',
      'metal_platinum': 'بلاتين',
      'metal_palladium': 'بلاديوم',
      'metal_steel': 'فولاذ',
    },
    'en': {
      'appName': 'Metal Weight Calculator',
      'poweredBy': 'Powered by',
      'companyName': 'Synaptix',
      'calculator': 'Calculator',
      'prices': 'Prices',
      'history': 'History',
      'settings': 'Settings',
      'selectMetal': 'Select Metal',
      'copper': 'Copper',
      'aluminum': 'Aluminum',
      'iron': 'Iron',
      'selectShape': 'Select Shape',
      'rectangle': 'Rectangle',
      'circle': 'Circle',
      'enterMeasurements': 'Enter Measurements',
      'length': 'Length (cm)',
      'width': 'Width (cm)',
      'diameter': 'Diameter (cm)',
      'thickness': 'Thickness (mm)',
      'calculateWeight': 'Calculate Weight',
      'required': 'Required',
      'fillAllFields': 'Please fill all required fields',
      'positiveNumber': 'Enter a positive number',
      'result': 'Calculation Result',
      'weight': 'Weight',
      'kg': 'kg',
      'copyResult': 'Copy',
      'shareResult': 'Share',
      'saveFavorite': 'Save as Favorite',
      'removeFavorite': 'Remove from Favorites',
      'calculateAgain': 'Calculate Again',
      'close': 'Close',
      'copied': 'Copied to clipboard',
      'savedToFavorites': 'Saved to favorites',
      'removedFromFavorites': 'Removed from favorites',
      'reset': 'Reset',
      'confirmReset': 'Confirm Reset',
      'resetConfirmMessage': 'Are you sure you want to reset all fields?',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'noHistory': 'No calculations yet',
      'clearAll': 'Clear All',
      'confirmClearHistory': 'Clear History',
      'clearHistoryMessage': 'Are you sure you want to clear all calculations?',
      'favoritesOnly': 'Favorites Only',
      'allCalculations': 'All Calculations',
      'noFavorites': 'No favorites saved',
      'marketPrices': 'Metal Prices',
      'liveMarketPrices': 'Live Market Prices',
      'lastUpdated': 'Last updated',
      'perTonne': 'per tonne',
      'perKg': 'per kg',
      'loading': 'Loading...',
      'failedToLoad': 'Failed to load prices',
      'retry': 'Retry',
      'refresh': 'Refresh',
      'pullToRefresh': 'Pull to refresh',
      'theme': 'Theme',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'language': 'Language',
      'english': 'English',
      'arabic': 'Arabic',
      'about': 'About',
      'version': 'Version',
      'developer': 'Developer',
      'privacyPolicy': 'Privacy Policy',
      'contactDeveloper': 'Contact Developer',
      'rateApp': 'Rate App',
      'shareApp': 'Share App',
      'appearance': 'Appearance',
      'support': 'Support',
      'credits': 'Credits',
      'gold': 'Gold',
      'silver': 'Silver',
      'zinc': 'Zinc',
      'nickel': 'Nickel',
      'lead': 'Lead',
      'tin': 'Tin',
      'platinum': 'Platinum',
      'palladium': 'Palladium',
      'metal_copper': 'Copper',
      'metal_aluminum': 'Aluminum',
      'metal_aluminium': 'Aluminum',
      'metal_iron': 'Iron',
      'metal_iron ore': 'Iron Ore',
      'metal_zinc': 'Zinc',
      'metal_nickel': 'Nickel',
      'metal_gold': 'Gold',
      'metal_silver': 'Silver',
      'metal_lead': 'Lead',
      'metal_tin': 'Tin',
      'metal_platinum': 'Platinum',
      'metal_palladium': 'Palladium',
      'metal_steel': 'Steel',
    },
  };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
