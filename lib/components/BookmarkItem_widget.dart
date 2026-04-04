import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bookmark_item_model.dart';
export 'bookmark_item_model.dart';

class BookmarkItemWidget extends StatefulWidget {
  const BookmarkItemWidget({
    super.key,
    this.img_bg,
    this.site,
    this.url,
    this.time,
    this.onDelete,
  });

  final String? img_bg;
  final String? site;
  final String? url;
  final String? time;
  final VoidCallback? onDelete;

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

  Color _parseHex(String? hex) {
    if (hex == null) return const Color(0xFFC5A073);
    final clean = hex.replaceAll('#', '').trim();
    if (clean.length == 6) return Color(int.parse('FF$clean', radix: 16));
    return const Color(0xFFC5A073);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remove bookmark?',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                )),
        content: Text('This will remove "${widget.site}" from your bookmarks.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.outfit(),
                  color: FlutterFlowTheme.of(context).secondaryText,
                )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: TextStyle(color: FlutterFlowTheme.of(context).secondaryText)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Remove',
                style: TextStyle(color: FlutterFlowTheme.of(context).error)),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onDelete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 0, 0, FlutterFlowTheme.of(context).designToken.spacing.md),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              FlutterFlowTheme.of(context).designToken.radius.lg),
          border: Border.all(
            color: FlutterFlowTheme.of(context).divider,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    FlutterFlowTheme.of(context).designToken.radius.md),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _parseHex(widget.img_bg),
                    borderRadius: BorderRadius.circular(
                        FlutterFlowTheme.of(context).designToken.radius.md),
                  ),
                  child: (widget.url != null && widget.url!.isNotEmpty)
                      ? CachedNetworkImage(
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          imageUrl: widget.url!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const SizedBox.shrink(),
                        )
                      : const SizedBox.shrink(),
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
                      valueOrDefault<String>(widget.site, 'jumia.com.gh'),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.35,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      valueOrDefault<String>(widget.time, 'Saved 2 days ago'),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 11,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                            lineHeight: 1.27,
                          ),
                    ),
                  ].divide(SizedBox(
                      height:
                          FlutterFlowTheme.of(context).designToken.spacing.xs)),
                ),
              ),
              if (widget.onDelete != null)
                FlutterFlowIconButton(
                  buttonSize: 40.0,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: FlutterFlowTheme.of(context).error,
                    size: 18,
                  ),
                  onPressed: () => _confirmDelete(context),
                )
              else
                Icon(
                  Icons.favorite_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 18,
                ),
            ].divide(SizedBox(
                width: FlutterFlowTheme.of(context).designToken.spacing.md)),
          ),
        ),
      ),
    );
  }
}
