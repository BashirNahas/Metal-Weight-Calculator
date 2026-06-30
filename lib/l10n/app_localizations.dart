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
  String get moreMetals => _t('moreMetals');
  String get swapLabel => _t('swapLabel');
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
  String get french => _t('french');
  String get german => _t('german');
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
      'moreMetals': 'معادن\nأخرى',
      'swapLabel': 'تغيير',
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
      'french': 'الفرنسية',
      'german': 'الألمانية',
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
      'moreMetals': 'More\nMetals',
      'swapLabel': 'Swap',
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
      'french': 'French',
      'german': 'German',
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
    'fr': {
      'appName': 'Nahas MetalHub',
      'poweredBy': 'Propulsé par',
      'companyName': 'Synaptix',
      'calculator': 'Calculatrice',
      'prices': 'Prix',
      'history': 'Historique',
      'settings': 'Paramètres',
      'selectMetal': 'Choisir le métal',
      'copper': 'Cuivre',
      'aluminum': 'Aluminium',
      'iron': 'Fer',
      'selectShape': 'Choisir la forme',
      'rectangle': 'Plaque rectangulaire',
      'circle': 'Disque rond',
      'squareBar': 'Barre carrée',
      'roundBar': 'Barre ronde',
      'hexBar': 'Barre hexagonale',
      'pipe': 'Tube / Tuyau',
      'squareTube': 'Tube carré',
      'moreShapes': 'Autres\nformes',
      'changeLabel': 'Changer',
      'moreMetals': 'Autres\nmétaux',
      'swapLabel': 'Changer',
      'enterMeasurements': 'Entrer les mesures',
      'length': 'Longueur',
      'width': 'Largeur',
      'diameter': 'Diamètre',
      'thickness': 'Épaisseur',
      'side': 'Côté',
      'acrossFlats': 'Entre méplats',
      'outerDiameter': 'Diamètre extérieur',
      'wallThickness': 'Épaisseur de paroi',
      'calculateWeight': 'Calculer le poids',
      'required': 'Requis',
      'fillAllFields': 'Veuillez remplir tous les champs requis',
      'positiveNumber': 'Entrez un nombre positif',
      'measurementUnit': 'Unité de mesure',
      'millimeter': 'mm',
      'centimeter': 'cm',
      'inch': 'pouce',
      'result': 'Résultat du calcul',
      'weight': 'Poids',
      'kg': 'kg',
      'copyResult': 'Copier',
      'shareResult': 'Partager',
      'saveFavorite': 'Ajouter aux favoris',
      'removeFavorite': 'Retirer des favoris',
      'calculateAgain': 'Nouveau calcul',
      'close': 'Fermer',
      'copied': 'Copié dans le presse-papiers',
      'savedToFavorites': 'Ajouté aux favoris',
      'removedFromFavorites': 'Retiré des favoris',
      'reset': 'Réinitialiser',
      'confirmReset': 'Confirmer la réinitialisation',
      'resetConfirmMessage': 'Voulez-vous réinitialiser tous les champs ?',
      'cancel': 'Annuler',
      'confirm': 'Confirmer',
      'noHistory': 'Aucun calcul pour le moment',
      'clearAll': 'Tout effacer',
      'confirmClearHistory': "Effacer l'historique",
      'clearHistoryMessage': 'Voulez-vous effacer tous les calculs ?',
      'favoritesOnly': 'Favoris uniquement',
      'allCalculations': 'Tous les calculs',
      'noFavorites': 'Aucun favori enregistré',
      'marketPrices': 'Prix des métaux',
      'liveMarketPrices': 'Prix du marché en direct',
      'lastUpdated': 'Dernière mise à jour',
      'perTonne': 'par tonne',
      'perKg': 'par kg',
      'perOunce': 'par once',
      'loading': 'Chargement...',
      'failedToLoad': 'Échec du chargement des prix',
      'retry': 'Réessayer',
      'refresh': 'Actualiser',
      'pullToRefresh': 'Tirer pour actualiser',
      'theme': 'Thème',
      'light': 'Clair',
      'dark': 'Sombre',
      'system': 'Système',
      'language': 'Langue',
      'english': 'Anglais',
      'arabic': 'Arabe',
      'french': 'Français',
      'german': 'Allemand',
      'about': 'À propos',
      'version': 'Version',
      'developer': 'Développeur',
      'privacyPolicy': 'Politique de confidentialité',
      'contactDeveloper': 'Contacter le développeur',
      'rateApp': "Évaluer l'application",
      'shareApp': "Partager l'application",
      'appearance': 'Apparence',
      'support': 'Support',
      'credits': 'Crédits',
      'priceUnit': "Unité d'affichage des prix",
      'tonneUnit': 'Tonne',
      'kgUnit': 'Kg',
      'ounceUnit': 'Once',
      'gold': 'Or',
      'silver': 'Argent',
      'zinc': 'Zinc',
      'nickel': 'Nickel',
      'lead': 'Plomb',
      'tin': 'Étain',
      'platinum': 'Platine',
      'palladium': 'Palladium',
      'steel': 'Acier',
      'stainlessSteel': 'Inox',
      'brass': 'Laiton',
      'titanium': 'Titane',
      'bronze': 'Bronze',
      'magnesium': 'Magnésium',
      'tungsten': 'Tungstène',
      'metal_copper': 'Cuivre',
      'metal_aluminum': 'Aluminium',
      'metal_aluminium': 'Aluminium',
      'metal_iron': 'Fer',
      'metal_iron ore': 'Minerai de fer',
      'metal_zinc': 'Zinc',
      'metal_nickel': 'Nickel',
      'metal_gold': 'Or',
      'metal_silver': 'Argent',
      'metal_lead': 'Plomb',
      'metal_tin': 'Étain',
      'metal_platinum': 'Platine',
      'metal_palladium': 'Palladium',
      'metal_steel': 'Acier',
    },
    'de': {
      'appName': 'Nahas MetalHub',
      'poweredBy': 'Bereitgestellt von',
      'companyName': 'Synaptix',
      'calculator': 'Rechner',
      'prices': 'Preise',
      'history': 'Verlauf',
      'settings': 'Einstellungen',
      'selectMetal': 'Metall auswählen',
      'copper': 'Kupfer',
      'aluminum': 'Aluminium',
      'iron': 'Eisen',
      'selectShape': 'Form auswählen',
      'rectangle': 'Rechteckige Platte',
      'circle': 'Runde Scheibe',
      'squareBar': 'Vierkantstab',
      'roundBar': 'Rundstab',
      'hexBar': 'Sechskantstab',
      'pipe': 'Rohr',
      'squareTube': 'Vierkantrohr',
      'moreShapes': 'Weitere\nFormen',
      'changeLabel': 'Ändern',
      'moreMetals': 'Weitere\nMetalle',
      'swapLabel': 'Ändern',
      'enterMeasurements': 'Maße eingeben',
      'length': 'Länge',
      'width': 'Breite',
      'diameter': 'Durchmesser',
      'thickness': 'Dicke',
      'side': 'Seite',
      'acrossFlats': 'Schlüsselweite',
      'outerDiameter': 'Außendurchmesser',
      'wallThickness': 'Wandstärke',
      'calculateWeight': 'Gewicht berechnen',
      'required': 'Erforderlich',
      'fillAllFields': 'Bitte alle erforderlichen Felder ausfüllen',
      'positiveNumber': 'Geben Sie eine positive Zahl ein',
      'measurementUnit': 'Maßeinheit',
      'millimeter': 'mm',
      'centimeter': 'cm',
      'inch': 'Zoll',
      'result': 'Berechnungsergebnis',
      'weight': 'Gewicht',
      'kg': 'kg',
      'copyResult': 'Kopieren',
      'shareResult': 'Teilen',
      'saveFavorite': 'Zu Favoriten hinzufügen',
      'removeFavorite': 'Aus Favoriten entfernen',
      'calculateAgain': 'Neu berechnen',
      'close': 'Schließen',
      'copied': 'In die Zwischenablage kopiert',
      'savedToFavorites': 'Zu Favoriten hinzugefügt',
      'removedFromFavorites': 'Aus Favoriten entfernt',
      'reset': 'Zurücksetzen',
      'confirmReset': 'Zurücksetzen bestätigen',
      'resetConfirmMessage': 'Möchten Sie alle Felder zurücksetzen?',
      'cancel': 'Abbrechen',
      'confirm': 'Bestätigen',
      'noHistory': 'Noch keine Berechnungen',
      'clearAll': 'Alle löschen',
      'confirmClearHistory': 'Verlauf löschen',
      'clearHistoryMessage': 'Möchten Sie alle Berechnungen löschen?',
      'favoritesOnly': 'Nur Favoriten',
      'allCalculations': 'Alle Berechnungen',
      'noFavorites': 'Keine Favoriten gespeichert',
      'marketPrices': 'Metallpreise',
      'liveMarketPrices': 'Live-Marktpreise',
      'lastUpdated': 'Zuletzt aktualisiert',
      'perTonne': 'pro Tonne',
      'perKg': 'pro kg',
      'perOunce': 'pro Unze',
      'loading': 'Wird geladen...',
      'failedToLoad': 'Preise konnten nicht geladen werden',
      'retry': 'Erneut versuchen',
      'refresh': 'Aktualisieren',
      'pullToRefresh': 'Zum Aktualisieren ziehen',
      'theme': 'Design',
      'light': 'Hell',
      'dark': 'Dunkel',
      'system': 'System',
      'language': 'Sprache',
      'english': 'Englisch',
      'arabic': 'Arabisch',
      'french': 'Französisch',
      'german': 'Deutsch',
      'about': 'Über',
      'version': 'Version',
      'developer': 'Entwickler',
      'privacyPolicy': 'Datenschutzrichtlinie',
      'contactDeveloper': 'Entwickler kontaktieren',
      'rateApp': 'App bewerten',
      'shareApp': 'App teilen',
      'appearance': 'Erscheinungsbild',
      'support': 'Support',
      'credits': 'Credits',
      'priceUnit': 'Preisanzeigeeinheit',
      'tonneUnit': 'Tonne',
      'kgUnit': 'Kg',
      'ounceUnit': 'Unze',
      'gold': 'Gold',
      'silver': 'Silber',
      'zinc': 'Zink',
      'nickel': 'Nickel',
      'lead': 'Blei',
      'tin': 'Zinn',
      'platinum': 'Platin',
      'palladium': 'Palladium',
      'steel': 'Stahl',
      'stainlessSteel': 'Edelstahl',
      'brass': 'Messing',
      'titanium': 'Titan',
      'bronze': 'Bronze',
      'magnesium': 'Magnesium',
      'tungsten': 'Wolfram',
      'metal_copper': 'Kupfer',
      'metal_aluminum': 'Aluminium',
      'metal_aluminium': 'Aluminium',
      'metal_iron': 'Eisen',
      'metal_iron ore': 'Eisenerz',
      'metal_zinc': 'Zink',
      'metal_nickel': 'Nickel',
      'metal_gold': 'Gold',
      'metal_silver': 'Silber',
      'metal_lead': 'Blei',
      'metal_tin': 'Zinn',
      'metal_platinum': 'Platin',
      'metal_palladium': 'Palladium',
      'metal_steel': 'Stahl',
    },
  };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'fr', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
