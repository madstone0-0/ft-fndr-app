import 'package:ft_fndr_app/providers/AuthNotifier.dart';
import 'package:ft_fndr_app/services/Locator.dart';

import '/components/bookmark_item_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bookmarks_model.dart';
export 'bookmarks_model.dart';

class BookmarksWidget extends StatefulWidget {
  const BookmarksWidget({super.key});

  static String routeName = 'Bookmarks';
  static String routePath = '/bookmarks';

  @override
  State<BookmarksWidget> createState() => _BookmarksWidgetState();
}

class _BookmarksWidgetState extends State<BookmarksWidget> {
  late BookmarksModel _model;
  late AuthNotifier _authNotifier;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookmarksModel());
    _authNotifier = getIt<AuthNotifier>();
    _authNotifier.addListener(_onAuthStateChanged);

    if (_authNotifier.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadBookmarks());
    }
  }

  @override
  void dispose() {
    _model.dispose();
    _authNotifier.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (!mounted) return;
    setState(() {
      if (_authNotifier.isAuthenticated) {
        _loadBookmarks();
      }
    });
  }

  Future<void> _loadBookmarks() async {
    await _model.loadBookmarks();
    _model.initBookmarkItemModels(context);
    if (mounted) safeSetState(() {});
  }

  Future<void> _deleteBookmark(String bookmarkId) async {
    final success = await _model.deleteBookmark(bookmarkId);
    if (!mounted) return;
    if (success) {
      // Re-sync sub-models to match the new list length
      _model.initBookmarkItemModels(context);
      safeSetState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove bookmark. Please try again.'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    }
  }

  // ── Unauthenticated prompt ────────────────────────────────────────────────

  Widget _buildLoginPrompt(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_rounded, size: 64.0, color: theme.secondaryText),
            SizedBox(height: theme.designToken.spacing.lg),
            Text(
              'Sign in to view your bookmarks',
              style: theme.headlineSmall.override(
                font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: theme.designToken.spacing.sm),
            Text(
              'Your bookmarks will be saved and synced across devices when you log in.',
              style: theme.bodyMedium.override(color: theme.secondaryText),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: theme.designToken.spacing.xl),
            FFButtonWidget(
              onPressed: () => context.go('/profile'),
              text: 'Go to Profile',
              options: FFButtonOptions(
                width: 200.0,
                height: 48.0,
                color: theme.primary,
                textStyle: theme.titleSmall.override(
                  font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  color: Colors.white,
                ),
                borderRadius:
                    BorderRadius.circular(theme.designToken.radius.sm),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bookmarks',
          style: theme.headlineMedium.override(
            font: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontStyle: theme.headlineMedium.fontStyle,
            ),
            color: theme.primaryText,
            fontSize: 28.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
            fontStyle: theme.headlineMedium.fontStyle,
            lineHeight: 1.25,
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius:
                BorderRadius.circular(theme.designToken.radius.md),
            border: Border.all(color: theme.divider, width: 1),
          ),
          alignment: AlignmentDirectional(0, 0),
          child: Icon(Icons.menu_rounded, color: theme.primaryText, size: 24),
        ),
      ],
    );
  }

  // ── Stat cards ────────────────────────────────────────────────────────────

  Widget _buildStats(BuildContext context) {
    final spacing = FlutterFlowTheme.of(context).designToken.spacing.md;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: wrapWithModel(
            model: _model.statCardModel1,
            updateCallback: () => safeSetState(() {}),
            child: StatCardWidget(
              count: _model.historyItems.length.toDouble(),
              label: 'SEARCHES',
            ),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: wrapWithModel(
            model: _model.statCardModel2,
            updateCallback: () => safeSetState(() {}),
            child: StatCardWidget(
              count: _model.savedCount.toDouble(),
              label: 'SAVED',
            ),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: wrapWithModel(
            model: _model.statCardModel3,
            updateCallback: () => safeSetState(() {}),
            child: StatCardWidget(
              count: _model.sitesCount.toDouble(),
              label: 'ITEMS',
            ),
          ),
        ),
      ],
    );
  }

  // ── Bookmark list ─────────────────────────────────────────────────────────

  Widget _buildBookmarksList(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final spacing = theme.designToken.spacing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BOOKMARKED ITEMS',
          style: theme.labelLarge.override(
            font: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontStyle: theme.labelLarge.fontStyle,
            ),
            color: theme.primaryText,
            fontSize: 15,
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
            fontStyle: theme.labelLarge.fontStyle,
            lineHeight: 1.33,
          ),
        ),
        SizedBox(height: spacing.md),
        for (int i = 0; i < _model.bookmarks.length; i++)
          wrapWithModel(
            model: _model.bookmarkItemModels[i],
            updateCallback: () => safeSetState(() {}),
            child: BookmarkItemWidget(
              img_bg: _model.bookmarks[i].colourHex,
              site: _model.bookmarks[i].title,
              url: _model.bookmarks[i].imgDesc,
              time: _model.bookmarks[i].savedLabel,
              onDelete: () => _deleteBookmark(_model.bookmarks[i].id),
            ),
          ),
      ],
    );
  }

  // ── Past searches chips ───────────────────────────────────────────────────

  Widget _buildPastSearches(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final spacing = theme.designToken.spacing;
    final items = _model.historyItems;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PAST SEARCHES',
          style: theme.labelLarge.override(
            font: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontStyle: theme.labelLarge.fontStyle,
            ),
            color: theme.primaryText,
            fontSize: 15,
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
            fontStyle: theme.labelLarge.fontStyle,
            lineHeight: 1.33,
          ),
        ),
        SizedBox(height: spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: items.map((h) => _buildChip(context, h.title)).toList(),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    final theme = FlutterFlowTheme.of(context);
    final spacing = theme.designToken.spacing;
    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(theme.designToken.radius.md),
        border: Border.all(color: theme.divider, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: spacing.lg, vertical: spacing.sm),
        child: Text(
          label,
          style: theme.bodySmall.override(
            font: GoogleFonts.outfit(fontWeight: FontWeight.w500),
            color: theme.primaryText,
          ),
        ),
      ),
    );
  }

  // ── Loading / error / empty states ────────────────────────────────────────

  Widget _buildStatusBody(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return switch (_model.status) {
      BookmarksStatus.initial ||
      BookmarksStatus.loading =>
        const Center(child: CircularProgressIndicator()),
      BookmarksStatus.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded,
                  color: theme.error, size: 48.0),
              const SizedBox(height: 12.0),
              Text(
                _model.errorMessage ?? 'Something went wrong.',
                style: theme.bodyMedium.override(
                  font: GoogleFonts.outfit(),
                  color: theme.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              TextButton(
                  onPressed: _loadBookmarks, child: const Text('Retry')),
            ],
          ),
        ),
      BookmarksStatus.empty => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bookmark_border_rounded,
                  size: 64.0, color: theme.secondaryText),
              SizedBox(height: theme.designToken.spacing.lg),
              Text(
                'No bookmarks yet',
                style: theme.headlineSmall.override(
                  font: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.w600),
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: theme.designToken.spacing.sm),
              Text(
                'Save items from your search results to find them here.',
                style: theme.bodyMedium.override(color: theme.secondaryText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      BookmarksStatus.success => const SizedBox.shrink(),
    };
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final spacing = FlutterFlowTheme.of(context).designToken.spacing;

    // Unauthenticated — lives inside the shell, no Scaffold
    if (!_authNotifier.isAuthenticated) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                spacing.lg, spacing.md, spacing.lg, spacing.md),
            child: Row(children: [
              Text(
                'Bookmarks',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.bold),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      lineHeight: 1.25,
                    ),
              ),
            ]),
          ),
          Expanded(child: _buildLoginPrompt(context)),
        ],
      );
    }

    // Authenticated
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context),
              SizedBox(height: spacing.lg),

              // Stats — visible once we have real data
              if (_model.status == BookmarksStatus.success ||
                  _model.status == BookmarksStatus.empty) ...[
                _buildStats(context),
                SizedBox(height: spacing.lg),
              ],

              // Loading / error / empty placeholder
              if (_model.status != BookmarksStatus.success)
                SizedBox(height: 200, child: _buildStatusBody(context)),

              // Live data sections
              if (_model.status == BookmarksStatus.success) ...[
                _buildBookmarksList(context),
                SizedBox(height: spacing.lg),
                _buildPastSearches(context),
              ],

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
