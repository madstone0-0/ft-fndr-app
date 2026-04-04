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
  }

  @override
  void dispose() {
    _model.dispose();
    _authNotifier.removeListener(_onAuthStateChanged);

    super.dispose();
  }

  void _onAuthStateChanged() {
    if (mounted) {
      setState(() {
      // Rebuild the widget when auth state changes
    });
    }
  }

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
              style: theme.bodyMedium.override(
                color: theme.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: theme.designToken.spacing.xl),
            FFButtonWidget(
              onPressed: () {
                // Navigate to Profile tab
                context.go('/profile');
              },
              text: 'Go to Profile',
              options: FFButtonOptions(
                width: 200.0,
                height: 48.0,
                color: theme.primary,
                textStyle: theme.titleSmall.override(
                  font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is authenticated
    if (!_authNotifier.isAuthenticated) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  FlutterFlowTheme.of(context).designToken.spacing.md),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bookmarks',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 28.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontStyle,
                      lineHeight: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Login prompt
          Expanded(child: _buildLoginPrompt(context)),
        ],
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.lg),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bookmarks',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.playfairDisplay(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 28,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                                lineHeight: 1.25,
                              ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(
                            FlutterFlowTheme.of(context).designToken.radius.md),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).divider,
                          width: 1,
                        ),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Icon(
                        Icons.menu_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: wrapWithModel(
                        model: _model.statCardModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: StatCardWidget(
                          count: 12.0,
                          label: 'SEARCHES',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: wrapWithModel(
                        model: _model.statCardModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: StatCardWidget(
                          count: 4.0,
                          label: 'SAVED',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: wrapWithModel(
                        model: _model.statCardModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: StatCardWidget(
                          count: 3.0,
                          label: 'SITES',
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.md)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BOOKMARKED LINKS',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 15,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                            lineHeight: 1.33,
                          ),
                    ),
                    wrapWithModel(
                      model: _model.bookmarkItemModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: BookmarkItemWidget(
                        img_bg: '#C5A073',
                        site: 'jumia.com.gh',
                        url: 'https://group.jumia.com/',
                        time: 'Saved 2 days ago',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.bookmarkItemModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: BookmarkItemWidget(
                        img_bg: '#8CAF7D',
                        site: 'instagram.com',
                        url: 'https://www.instagram.com/p/abc123',
                        time: 'Saved 5 days ago',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.bookmarkItemModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: BookmarkItemWidget(
                        img_bg: '#A1B4CF',
                        site: 'tonaton.com',
                        url: 'https://www.tonaton.com/clothing/',
                        time: 'Saved 1 day ago',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.bookmarkItemModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: BookmarkItemWidget(
                        img_bg: '#D3A7C1',
                        site: 'meqasa.com',
                        url: 'https://www.tonaton.com/clothing/',
                        time: 'Saved 8 days ago',
                      ),
                    ),
                  ].divide(SizedBox(
                      height:
                          FlutterFlowTheme.of(context).designToken.spacing.md)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PAST SEARCHES',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 15,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                            lineHeight: 1.33,
                          ),
                    ),
                    Wrap(
                      spacing:
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                      runSpacing:
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md),
                            child: FlutterFlowChoiceChips(
                              options: [ChipData('Kente')],
                              onChanged: (val) => safeSetState(() =>
                                  _model.choiceChipsValue1 = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              chipSpacing: 0,
                              multiselect: false,
                              controller: _model.choiceChipsValueController1 ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md),
                            child: FlutterFlowChoiceChips(
                              options: [ChipData('Dashiki')],
                              onChanged: (val) => safeSetState(() =>
                                  _model.choiceChipsValue2 = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              chipSpacing: 0,
                              multiselect: false,
                              controller: _model.choiceChipsValueController2 ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md),
                            child: FlutterFlowChoiceChips(
                              options: [ChipData('Shorts')],
                              onChanged: (val) => safeSetState(() =>
                                  _model.choiceChipsValue3 = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              chipSpacing: 0,
                              multiselect: false,
                              controller: _model.choiceChipsValueController3 ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .lg,
                                FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .md),
                            child: FlutterFlowChoiceChips(
                              options: [ChipData('T-shirt')],
                              onChanged: (val) => safeSetState(() =>
                                  _model.choiceChipsValue4 = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18,
                                labelPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                elevation: 0,
                                borderColor:
                                    FlutterFlowTheme.of(context).divider,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              chipSpacing: 0,
                              multiselect: false,
                              controller: _model.choiceChipsValueController4 ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(
                      height:
                          FlutterFlowTheme.of(context).designToken.spacing.md)),
                ),
                Container(
                  height: 80,
                ),
              ].divide(SizedBox(
                  height: FlutterFlowTheme.of(context).designToken.spacing.lg)),
            ),
          ),
        ),
      ),
    );
  }
}
