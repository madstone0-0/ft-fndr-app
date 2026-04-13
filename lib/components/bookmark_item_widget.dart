import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookmark_item_model.dart';
export 'bookmark_item_model.dart';

class BookmarkItemWidget extends StatefulWidget {
  const BookmarkItemWidget({
    super.key,
    this.imgUrl,
    this.site,
    this.url,
    this.time,
    required Future<void> Function() onDelete,
  });

  final String? imgUrl;
  final String? site;
  final String? url;
  final String? time;

  @override
  State<BookmarkItemWidget> createState() => _BookmarkItemWidgetState();
}

class _BookmarkItemWidgetState extends State<BookmarkItemWidget> {
  late BookmarkItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookmarkItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, FlutterFlowTheme.of(context).designToken.spacing.md),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
          border: Border.all(
            color: FlutterFlowTheme.of(context).divider,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md,
                ),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: widget.imgUrl != null && widget.imgUrl!.isNotEmpty
                      ? Image.network(
                    widget.imgUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFC5A073),
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFC5A073),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  )
                      : Container(color: const Color(0xFFC5A073)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.site,
                        'jumia.com.gh',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                            lineHeight: 1.35,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.url,
                        'https://group.jumia.com/',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                            lineHeight: 1.38,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.time,
                        'Saved 2 days ago',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                            lineHeight: 1.27,
                          ),
                    ),
                  ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                ),
              ),
              Icon(
                Icons.favorite_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 18.0,
              ),
            ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.md)),
          ),
        ),
      ),
    );
  }
}
