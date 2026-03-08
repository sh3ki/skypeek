import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool lightText;

  const AppLogo({
    super.key,
    this.size = 48,
    this.showText = true,
    this.lightText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size * 0.18,
                right: size * 0.12,
                child: Icon(
                  Icons.wb_sunny_rounded,
                  color: Colors.amber.shade300,
                  size: size * 0.45,
                ),
              ),
              Positioned(
                bottom: size * 0.14,
                left: size * 0.08,
                child: Icon(
                  Icons.cloud_rounded,
                  color: Colors.white,
                  size: size * 0.52,
                ),
              ),
            ],
          ),
        ),
        if (showText) ...[
          SizedBox(width: size * 0.2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Sky',
                  style: TextStyle(
                    fontSize: size * 0.48,
                    fontWeight: FontWeight.w900,
                    color: lightText ? Colors.white : AppTheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Peek',
                  style: TextStyle(
                    fontSize: size * 0.48,
                    fontWeight: FontWeight.w400,
                    color: lightText
                        ? Colors.white.withOpacity(0.85)
                        : AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
