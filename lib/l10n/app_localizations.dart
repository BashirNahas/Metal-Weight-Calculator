import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/models/metal.dart';

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
  String get squareBar => _t('squareBar');
  String get roundBar => _t('roundBar');
  String get hexBar => _t('hexBar');
  String get pipe => _t('pipe');
  String get squareTube => _t('squareTube');
  String get moreShapes => _t('moreShapes');
  String get changeLabel => _t('changeLabel');
  String get enterMeasurements => _t('enterMeasurements');
  String get length => _t('length');
  String get width => _t('width');
  String get diameter => _t('diameter');
  String get thickness => _t('thickness');
  String get side => _t('side');
  String get acrossFlats => _t('acrossFlats');
  String get outerDiameter => _t('outerDiameter');
  String get wallThickness => _t('wallThickness');
  String get calculateWeight => _t('calculateWeight');
  String get required => _t('required');
  String get fillAllFields => _t('fillAllFields');
  String get positiveNumber => _t('positiveNumber');

  // Measurement units (settings)
  String get measurementUnit => _t('measurementUnit');
  String get millimeter => _t('millimeter');
  String get centimeter => _t('centimeter');
  String get inch => _t('inch');

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
  String get perOunce => _t('perOunce');
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
  String get priceUnit => _t('priceUnit');
  String get tonneUnit => _t('tonneUnit');
  String get kgUnit => _t('kgUnit');
  String get ounceUnit => _t('ounceUnit');

  // Metal names (market)
  String get gold => _t('gold');
  String get silver => _t('silver');
  String get zinc => _t('zinc');
  String get nickel => _t('nickel');
  String get lead => _t('lead');
  String get tin => _t('tin');
  String get platinum => _t('platinum');
  String get palladium => _t('palladium');
  String get steel => _t('steel');
  String get stainlessSteel => _t('stainlessSteel');
  String get brass => _t('brass');
  String get titanium => _t('titanium');
  String get bronze => _t('bronze');
  String get magnesium => _t('magnesium');
  String get tungsten => _t('tungsten');

  // Helper: market-price API names (e.g. "iron ore", "XAU") — not part of
  // the calculator's Metal enum.
  String metalName(String key) =>
      _t('metal_$key') != 'metal_$key' ? _t('metal_$key') : key;

  // Helper: localized label for a calculator Metal enum value.
  String metalLabel(Metal m) => switch (m) {
        Metal.copper => copper,
        Metal.aluminum => aluminum,
        Metal.iron => iron,
        Metal.steel => steel,
        Metal.stainlessSteel => stainlessSteel,
        Metal.zinc => zinc,
        Metal.nickel => nickel,
        Metal.lead => lead,
        Metal.brass => brass,
        Metal.titanium => titanium,
        Metal.gold => gold,
        Metal.silver => silver,
        Metal.bronze => bronze,
        Metal.magnesium => magnesium,
        Metal.tungsten => tungsten,
      };

  // Helper: localized label for a calculator Shape enum value.
  String shapeLabel(Shape s) => switch (s) {
        Shape.rectangle => rectangle,
        Shape.circle => circle,
        Shape.squareBar => squareBar,
        Shape.roundBar => roundBar,
        Shape.hexBar => hexBar,
        Shape.pipe => pipe,
        Shape.squareTube => squareTube,
      };

  static const Map<String, Map<String, String>> _strings = {
    'ar': {
      'appName': 'Nahas MetalHub',
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
      'rectangle': 'لوحة مستطيلة',
      'circle': 'قرص دائري',
      'squareBar': 'قضيب مربع',
      'roundBar': 'قضيب دائري',
      'hexBar': 'قضيب سداسي',
      'pipe': 'أنبوب',
      'squareTube': 'أنبوب مربع',
      'moreShapes': 'أشكال\nأخرى',
      'changeLabel': 'تغيير',
      'enterMeasurements': 'أدخل القياسات',
      'length': 'الطول',
      'width': 'العرض',
      'diameter': 'القطر',
      'thickness': 'السماكة',
      'side': 'الجانب',
      'acrossFlats': 'بين الوجوه',
      'outerDiameter': 'القطر الخارجي',
      'wallThickness': 'سُمك الجدار',
      'calculateWeight': 'احسب الوزن',
      'required': 'مطلوب',
      'fillAllFields': 'يرجى ملء جميع الحقول المطلوبة',
      'positiveNumber': 'أدخل رقماً موجباً',
      'measurementUnit': 'وحدة القياس',
      'millimeter': 'ملم',
      'centimeter': 'سم',
      'inch': 'إنش',
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
      'perOunce': 'لكل أونصة',
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
      'priceUnit': 'وحدة عرض الأسعار',
      'tonneUnit': 'طن',
      'kgUnit': 'كغ',
      'ounceUnit': 'أونصة',
      'gold': 'ذهب',
      'silver': 'فضة',
      'zinc': 'زنك',
      'nickel': 'نيكل',
      'lead': 'رصاص',
      'tin': 'قصدير',
      'platinum': 'بلاتين',
      'palladium': 'بلاديوم',
      'steel': 'فولاذ',
      'stainlessSteel': 'استانلس',
      'brass': 'نحاس أصفر',
      'titanium': 'تيتانيوم',
      'bronze': 'برونز',
      'magnesium': 'مغنيسيوم',
      'tungsten': 'تنغستن',
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
      'appName': 'Nahas MetalHub',
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
      'rectangle': 'Flat Plate',
      'circle': 'Round Disc',
      'squareBar': 'Square Bar',
      'roundBar': 'Round Bar',
      'hexBar': 'Hex Bar',
      'pipe': 'Pipe / Tube',
      'squareTube': 'Square Tube',
      'moreShapes': 'More\nShapes',
      'changeLabel': 'Change',
      'enterMeasurements': 'Enter Measurements',
      'length': 'Length',
      'width': 'Width',
      'diameter': 'Diameter',
      'thickness': 'Thickness',
      'side': 'Side',
      'acrossFlats': 'Across Flats',
      'outerDiameter': 'Outer Ø',
      'wallThickness': 'Wall Thickness',
      'calculateWeight': 'Calculate Weight',
      'required': 'Required',
      'fillAllFields': 'Please fill all required fields',
      'positiveNumber': 'Enter a positive number',
      'measurementUnit': 'Measurement Unit',
      'millimeter': 'mm',
      'centimeter': 'cm',
      'inch': 'inch',
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
      'perOunce': 'per oz',
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
      'priceUnit': 'Price Display Unit',
      'tonneUnit': 'Tonne',
      'kgUnit': 'Kg',
      'ounceUnit': 'Ounce',
      'gold': 'Gold',
      'silver': 'Silver',
      'zinc': 'Zinc',
      'nickel': 'Nickel',
      'lead': 'Lead',
      'tin': 'Tin',
      'platinum': 'Platinum',
      'palladium': 'Palladium',
      'steel': 'Steel',
      'stainlessSteel': 'Stainless',
      'brass': 'Brass',
      'titanium': 'Titanium',
      'bronze': 'Bronze',
      'magnesium': 'Magnesium',
      'tungsten': 'Tungsten',
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
