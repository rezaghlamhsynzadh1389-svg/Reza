import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF08060D);
  static const bg2 = Color(0xFF0D0916);
  static const neon = Color(0xFFA855F7);
  static const neonSoft = Color(0xFF7C3AED);
  static const neon2 = Color(0xFFC084FC);
  static const cyan = Color(0xFF22D3EE);
  static const red = Color(0xFFFF4D6D);
  static const green = Color(0xFF2EE6A6);
  static const ink = Color(0xFFF3EEFC);
  static const inkDim = Color(0xFFA89BC4);
  static const inkFaint = Color(0xFF6B5F89);
  static const glass = Color(0x0BFFFFFF);
  static const glassBorder = Color(0x2EC084FC);
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.neon,
        secondary: AppColors.cyan,
        surface: AppColors.bg2,
      ),
      textTheme: GoogleFonts.vazirmatnTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? AppColors.glassBorder),
      ),
      child: child,
    );
  }
}
