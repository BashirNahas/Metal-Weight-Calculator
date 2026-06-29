![GitHub repo size](https://img.shields.io/github/repo-size/BashirNahas/Metal-Weight-Calculator)
![GitHub stars](https://img.shields.io/github/stars/BashirNahas/Metal-Weight-Calculator?style=social)

# Metal Weight Calculator | حساب وزن المعادن

A professional, production-ready **Flutter** app to calculate the weight of metals (copper, aluminum, iron) with live market prices, calculation history, dark/light themes, and full Arabic/English support. Powered by **Synaptix**.

تطبيق **Flutter** احترافي لحساب **وزن المعادن** مع أسعار السوق الحية، سجل الحسابات، وضع داكن/فاتح، ودعم كامل للعربية والإنجليزية. مدعوم من **Synaptix**.

---

## Live Web App | التطبيق على الويب

**Open on any device — no App Store needed:**

[https://bashirnahas.github.io/Metal-Weight-Calculator/](https://bashirnahas.github.io/Metal-Weight-Calculator/)

Supports "Add to Home Screen" on iPhone/iPad for a native app experience.

---

## Features | الميزات

- **Clean Architecture** — core / models / services / repositories / providers / screens / widgets
- **3 metals** — Copper (8.96 g/cm³), Aluminum (2.70), Iron (7.85)
- **2 shapes** — Rectangular plate & circular rod
- **Calculation history** — save, favorite, swipe-to-delete
- **Live metal market prices** — copper, aluminum, iron, gold, silver, and more via metals.dev API (15-min cache)
- **Copy & share results**
- **Dark / Light / System themes** — persisted across sessions
- **Arabic (default, RTL) + English** — switchable in Settings
- **Settings screen** — theme, language, about, privacy policy, contact, rate, share
- **"Powered by Synaptix"** branding throughout
- **PWA-ready** — installable from browser on iOS/Android/desktop

---

## Screenshots | لقطات الشاشة

### Splash Screen
![Splash Screen](https://github.com/user-attachments/assets/8b40a7ee-93b7-4a94-92df-f385e6823f53)

### Calculator
![Home Interface](https://github.com/user-attachments/assets/2f8969e9-b44b-441b-82fc-426b397dfa66)

### Input Fields
![Input Fields](https://github.com/user-attachments/assets/a2148873-80dc-45bb-ac4d-fc305c4e38a0)

### Result
![Calculation Result](https://github.com/user-attachments/assets/b1f06a6a-06d1-44d0-8669-3bcdb3529025)

---

## Installation | التثبيت

```bash
git clone https://github.com/BashirNahas/Metal-Weight-Calculator.git
cd Metal-Weight-Calculator
flutter pub get
flutter run
```

### Build Android APK

```bash
flutter build apk --release --dart-define=METALS_API_KEY=your_key
```

### Build Web

```bash
flutter build web --base-href /Metal-Weight-Calculator/ --release --dart-define=METALS_API_KEY=your_key
```

---

## Architecture | البنية

```
lib/
  core/constants/   — AppConstants, AppColors
  core/extensions/  — BuildContext helpers (l10n, isDark, showSnack)
  core/utils/       — AppFormatters (weight, price, date)
  models/           — Metal, Calculation, MetalPrice
  services/         — StorageService (SharedPreferences), MetalPriceService (HTTP)
  repositories/     — CalculationRepository, MetalPriceRepository (cache)
  providers/        — ThemeProvider, LocaleProvider, CalculatorProvider,
                      HistoryProvider, MarketPricesProvider
  theme/            — AppTheme (Material 3 light + dark)
  l10n/             — AppLocalizations (Arabic + English, manual delegate)
  screens/          — splash, home, calculator, history, market_prices, settings
  widgets/          — common, calculator, dialogs, market
```

---

## Play Store

- **App ID:** `com.synaptix.metalweightcalculator`
- **Min SDK:** 21 (Android 5.0)
- **Target SDK:** 35
- **ProGuard / R8** minification enabled for release
- Adaptive icons included

---

## Developer | المطوّر

- **Bashir Nahas** — [@BashirNahas](https://github.com/BashirNahas)
- Powered by **Synaptix**

## License

MIT — free to use, modify, and distribute with attribution.
