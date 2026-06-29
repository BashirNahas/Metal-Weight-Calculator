import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metal_weight_calculator/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.secondary,
            onPrimary: Colors.white,
            primaryContainer: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.cardDark,
            onSurface: AppColors.textPrimaryDark,
            surfaceContainerHighest: AppColors.surfaceDark,
            error: AppColors.error,
            outline: AppColors.borderDark,
          )
        : const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            primaryContainer: AppColors.surfaceLight,
            secondary: AppColors.secondary,
            surface: AppColors.cardLight,
            onSurface: AppColors.textPrimaryLight,
            surfaceContainerHighest: AppColors.surfaceLight,
            error: AppColors.error,
            outline: AppColors.borderLight,
          );

    final base = TextTheme(
      displayLarge: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.cairo(fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.cairo(fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.cairo(fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.cairo(fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.cairo(fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.cairo(),
      bodyMedium: GoogleFonts.cairo(),
      bodySmall: GoogleFonts.cairo(),
      labelLarge: GoogleFonts.cairo(fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.cairo(),
      labelSmall: GoogleFonts.cairo(),
    );

    final bg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      textTheme: base,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        foregroundColor:
            isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: AppColors.cardDark,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: AppColors.cardLight,
              ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        elevation: isDark ? 0 : 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isDark
              ? const BorderSide(color: AppColors.borderDark, width: 0.5)
              : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.secondary : AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: GoogleFonts.cairo(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          fontSize: 14,
        ),
        errorStyle: GoogleFonts.cairo(color: AppColors.error, fontSize: 12),
        prefixIconColor: isDark ? AppColors.secondary : AppColors.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? AppColors.secondary : AppColors.primary,
          textStyle: GoogleFonts.cairo(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? AppColors.cardDark : Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        elevation: 8,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.cairo(
            fontSize: 11,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected
                ? (isDark ? AppColors.secondary : AppColors.primary)
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 24,
            color: selected
                ? (isDark ? AppColors.secondary : AppColors.primary)
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight),
          );
        }),
        indicatorColor: isDark
            ? AppColors.primary.withValues(alpha: 0.3)
            : AppColors.primary.withValues(alpha: 0.12),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.borderDark : AppColors.borderLight,
        thickness: 0.5,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentTextStyle: GoogleFonts.cairo(color: Colors.white),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: isDark ? AppColors.cardDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        selectedColor:
            isDark ? AppColors.primary : AppColors.surfaceLight,
        labelStyle: GoogleFonts.cairo(fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
