import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static String weight(double kg, {String locale = 'ar'}) {
    final formatter = NumberFormat('#,##0.000', locale);
    return formatter.format(kg);
  }

  static String price(double value, {String currency = 'USD', String locale = 'en'}) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: '\$$currency ',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  static String priceSimple(double value, {String locale = 'en'}) {
    final formatter = NumberFormat('#,##0.00', locale);
    return '\$${formatter.format(value)}';
  }

  static String dateTime(DateTime dt, {String locale = 'ar'}) {
    return DateFormat('dd/MM/yyyy  HH:mm', locale).format(dt.toLocal());
  }

  static String timeAgo(DateTime dt, {bool isArabic = true}) {
    final diff = DateTime.now().difference(dt);
    if (isArabic) {
      if (diff.inMinutes < 1) return 'الآن';
      if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
      if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
      return 'منذ ${diff.inDays} ي';
    } else {
      if (diff.inMinutes < 1) return 'just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    }
  }
}
