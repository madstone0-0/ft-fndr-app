import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainShellWidget extends StatelessWidget {
  const MainShellWidget({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTabTapped(int index) {
    navigationShell.goBranch(
      index,
      // Return to the initial location of the branch when re-tapping the
      // active tab, so nested navigation inside a branch is reset.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = navigationShell.currentIndex;
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      // SafeArea on top ensures content never renders under the status bar.
      body: SafeArea(
        bottom: false,
        child: navigationShell,
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.onTabTapped,
  });

  final int currentIndex;
  final void Function(int) onTabTapped;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(
          top: BorderSide(color: theme.divider, width: 1.0),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            0.0,
            theme.designToken.spacing.md,
            0.0,
            theme.designToken.spacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                activeIcon: Icons.search_rounded,
                inactiveIcon: Icons.search_rounded,
                label: 'Search',
                onTap: onTabTapped,
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                activeIcon: Icons.history_rounded,
                inactiveIcon: Icons.history_rounded,
                label: 'History',
                onTap: onTabTapped,
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                activeIcon: Icons.bookmark_rounded,
                inactiveIcon: Icons.bookmark_outline_rounded,
                label: 'Saved',
                onTap: onTabTapped,
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                activeIcon: Icons.person_rounded,
                inactiveIcon: Icons.person_outline_rounded,
                label: 'Profile',
                onTap: onTabTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final bool isActive = index == currentIndex;
    final Color iconColor = isActive ? theme.primaryText : theme.secondaryText;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : inactiveIcon,
            color: iconColor,
            size: 24.0,
          ),
          Text(
            label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: iconColor,
                  fontSize: 11.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  lineHeight: 1.27,
                ),
          ),
        ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
      ),
    );
  }
}
