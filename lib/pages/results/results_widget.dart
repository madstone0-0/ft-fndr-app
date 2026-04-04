import '/components/filter_chip_widget.dart';
import '/components/result_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results_model.dart';
export 'results_model.dart';

class ResultsWidget extends StatefulWidget {
  const ResultsWidget({super.key});

  static String routeName = 'Results';
  static String routePath = '/results';

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  late ResultsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Results',
                        style: FlutterFlowTheme.of(context).headlineMedium.override(
                              font: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 28.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                              lineHeight: 1.25,
                            ),
                      ),
                      Text(
                        '12 links found',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              lineHeight: 1.47,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.md),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).divider,
                        width: 1.0,
                      ),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Icon(
                      Icons.menu_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.xl),
                        child: Container(
                          height: 220.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.xl),
                          ),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 0),
                                fadeOutDuration: Duration(milliseconds: 0),
                                imageUrl:
                                    'https://dimg.dreamflow.cloud/v1/image/fashion%20item%20search%20query%20photo',
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xCCFFFFFF),
                                      borderRadius:
                                          BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.full),
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        'Your search image',
                                        style: FlutterFlowTheme.of(context).labelSmall.override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 11.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                              lineHeight: 1.27,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '4 results · Accra, GH',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              lineHeight: 1.47,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          wrapWithModel(
                            model: _model.filterChipModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: FilterChipWidget(
                              selected: true,
                              label: 'All',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.filterChipModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: FilterChipWidget(
                              selected: false,
                              label: 'Local first',
                            ),
                          ),
                        ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.md)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.resultCardModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: ResultCardWidget(
                              img_bg: '#C89E6E',
                              title: 'jumia.com.gh',
                              url: 'https://group.jumia.com/',
                              type: 'Online store',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.resultCardModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ResultCardWidget(
                              img_bg: '#8EAC7E',
                              title: 'instagram.com',
                              url: 'https://www.instagram.com/p/abc123',
                              type: 'Instagram',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.resultCardModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: ResultCardWidget(
                              img_bg: '#A1B4D0',
                              title: 'tonaton.com',
                              url: 'https://www.tonaton.com/clothing/',
                              type: 'Marketplace',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.resultCardModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: ResultCardWidget(
                              img_bg: '#D4A5C1',
                              title: 'meqasa.com',
                              url: 'https://www.tonaton.com/clothing/',
                              type: 'Web page',
                            ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 32.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      Text(
                        'Search',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              lineHeight: 1.27,
                            ),
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      Text(
                        'History',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              lineHeight: 1.27,
                            ),
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_outline_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      Text(
                        'Saved',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              lineHeight: 1.27,
                            ),
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      Text(
                        'Profile',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                              lineHeight: 1.27,
                            ),
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
