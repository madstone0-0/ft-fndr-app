import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'recent_search_card_model.dart';
export 'recent_search_card_model.dart';

class RecentSearchCardWidget extends StatefulWidget {
  const RecentSearchCardWidget({
    super.key,
    this.bg_color,
    this.img_desc,
    this.label,
  });

  final Color? bg_color;
  final String? img_desc;
  final String? label;

  @override
  State<RecentSearchCardWidget> createState() => _RecentSearchCardWidgetState();
}

class _RecentSearchCardWidgetState extends State<RecentSearchCardWidget> {
  late RecentSearchCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecentSearchCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 0, FlutterFlowTheme.of(context).designToken.spacing.md, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.lg),
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget!.bg_color,
              Color(0x00000000),
            ),
            borderRadius: BorderRadius.circular(
                FlutterFlowTheme.of(context).designToken.radius.lg),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageUrl: valueOrDefault<String>(
                  widget!.img_desc,
                  'https://dimg.dreamflow.cloud/v1/image/kente%20cloth%20fabric%20pattern',
                ),
                fit: BoxFit.cover,
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0,
                        FlutterFlowTheme.of(context).designToken.spacing.md),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x88000000),
                        borderRadius: BorderRadius.circular(
                            FlutterFlowTheme.of(context).designToken.radius.sm),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            FlutterFlowTheme.of(context).designToken.spacing.md,
                            FlutterFlowTheme.of(context).designToken.spacing.xs,
                            FlutterFlowTheme.of(context).designToken.spacing.md,
                            FlutterFlowTheme.of(context)
                                .designToken
                                .spacing
                                .xs),
                        child: Text(
                          valueOrDefault<String>(
                            widget!.label,
                            'Kente top',
                          ),
                          maxLines: 1,
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 11,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.27,
                                  ),
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
