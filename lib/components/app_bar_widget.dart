import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';

class AppPageBar extends StatelessWidget implements PreferredSizeWidget {
  const AppPageBar({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return AppBar(
      backgroundColor: theme.primaryBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: theme.designToken.spacing.lg,
      title: Text(
        title,
        style: theme.headlineMedium.override(
          font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
          color: theme.primaryText,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          lineHeight: 1.25,
        ),
      ),
      actions: [
        if (action != null)
          Padding(
            padding: EdgeInsets.only(
              right: theme.designToken.spacing.lg,
            ),
            child: action!,
          ),
      ],
    );
  }
}

class AppPageBarAction extends StatelessWidget {
  const AppPageBarAction({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.designToken.spacing.sm,
          vertical: theme.designToken.spacing.xs,
        ),
        child: Center(
          child: Text(
            label,
            style: theme.labelMedium.override(
              font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              color: color ?? theme.primary,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              lineHeight: 1.38,
            ),
          ),
        ),
      ),
    );
  }
}