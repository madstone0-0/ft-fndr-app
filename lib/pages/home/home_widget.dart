import '/components/recent_search_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _openCameraSearch() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null && mounted) {
        context.pushNamed(
          'Results',
          extra: <String, dynamic>{'imageFilePath': pickedFile.path},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open camera. Please check camera permissions.'),
          ),
        );
      }
    }
  }

  Future<void> _openGallerySearch() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null && mounted) {
        context.pushNamed(
          'Results',
          extra: <String, dynamic>{'imageFilePath': pickedFile.path},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open gallery. Please check photo permissions.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                  'Ft Fndr',
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _openCameraSearch,
                  child: Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.lg),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.xl),
                      child: Container(
                        height: 360.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF16120D),
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context).designToken.radius.xl),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .lg),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).accent1,
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Point at any item',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                      font: GoogleFonts.playfairDisplay(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                      lineHeight: 1.27,
                                    ),
                                  ),
                                  Container(
                                    width: 72.0,
                                    height: 72.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .full),
                                      border: Border.all(
                                        color: Color(0xCCFFFFFF),
                                        width: 4.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).accent1,
                                          borderRadius: BorderRadius.circular(
                                              FlutterFlowTheme.of(context)
                                                  .designToken
                                                  .radius
                                                  .full),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(
                                    height: FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .lg)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        0.0,
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: _openGallerySearch,
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context).designToken.radius.lg),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .spacing
                                                .xl,
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md,
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .spacing
                                                .xl,
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .spacing
                                                .md),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.north_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 16.0,
                                            ),
                                            Text(
                                              'Upload photo',
                                              style: FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                                lineHeight: 1.38,
                                              ),
                                            ),
                                            Container(
                                              width: 0.0,
                                              height: 0.0,
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 0.0,
                                      height: 0.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(
                                  FlutterFlowTheme.of(context).designToken.radius.lg),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xl,
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .md,
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xl,
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .md),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Paste URL',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                              lineHeight: 1.38,
                                            ),
                                          ),
                                          Container(
                                            width: 0.0,
                                            height: 0.0,
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 0.0,
                                    height: 0.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(
                          width:
                          FlutterFlowTheme.of(context).designToken.spacing.md)),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Searches',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.35,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.recentSearchCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchCardWidget(
                                      bg_color: Color(0xFFC69C6D),
                                      img_desc:
                                      'https://dimg.dreamflow.cloud/v1/image/kente%20cloth%20fabric%20pattern',
                                      label: 'Kente top',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.recentSearchCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchCardWidget(
                                      bg_color: Color(0xFFA2B5CD),
                                      img_desc:
                                      'https://dimg.dreamflow.cloud/v1/image/blue%20denim%20shorts',
                                      label: 'Shorts',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.recentSearchCardModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchCardWidget(
                                      bg_color: Color(0xFFD4A5B9),
                                      img_desc:
                                      'https://dimg.dreamflow.cloud/v1/image/pink%20pleated%20skirt',
                                      label: 'Skirt',
                                    ),
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
                                    model: _model.recentSearchCardModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchCardWidget(
                                      bg_color: Color(0xFF8FAD7F),
                                      img_desc:
                                      'https://dimg.dreamflow.cloud/v1/image/green%20dashiki%20shirt',
                                      label: 'Dashiki',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 180.0,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 180.0,
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(
                              height: FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .md)),
                        ),
                      ].divide(SizedBox(
                          height:
                          FlutterFlowTheme.of(context).designToken.spacing.md)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
