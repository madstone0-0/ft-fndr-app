import '/components/history_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_history_model.dart';
export 'search_history_model.dart';

class SearchHistoryWidget extends StatefulWidget {
  const SearchHistoryWidget({super.key});

  static String routeName = 'SearchHistory';
  static String routePath = '/searchHistory';

  @override
  State<SearchHistoryWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  late SearchHistoryModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchHistoryModel());
    _model.textController ??= TextEditingController(text: '');
    _model.textFieldFocusNode ??= FocusNode();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    await _model.loadHistory();
    _model.initHistoryItemModels(context);
    if (mounted) safeSetState(() {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, FlutterFlowTheme.of(context).designToken.spacing.md),
      child: Text(
        label,
        style: FlutterFlowTheme.of(context).labelLarge.override(
              font: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 15.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
              lineHeight: 1.33,
            ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    int modelIndex = 0;
    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int g = 0; g < _model.historyGroups.length; g++) ...[
            if (g > 0) Container(height: FlutterFlowTheme.of(context).designToken.spacing.md),
            _buildSectionLabel(context, _model.historyGroups[g].label),
            for (final item in _model.historyGroups[g].items)
              wrapWithModel(
                model: _model.historyItemModels[modelIndex++],
                updateCallback: () => safeSetState(() {}),
                child: HistoryItemWidget(
                  img_desc: item.imgDesc,
                  title: item.title,
                  timestamp: item.timestamp,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBody(BuildContext context, SearchHistoryStatus status) {
    return switch (status) {
      SearchHistoryStatus.loading || SearchHistoryStatus.initial => const Center(child: CircularProgressIndicator()),
      SearchHistoryStatus.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, color: FlutterFlowTheme.of(context).error, size: 48.0),
              const SizedBox(height: 12.0),
              Text(
                _model.errorMessage ?? 'Something went wrong.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.outfit(),
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              const SizedBox(height: 12.0),
              TextButton(
                onPressed: _loadHistory,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.lg,
                FlutterFlowTheme.of(context).designToken.spacing.md,
                FlutterFlowTheme.of(context).designToken.spacing.lg,
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Search History',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 28.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        lineHeight: 1.25,
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.sm),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        FlutterFlowTheme.of(context).designToken.spacing.md,
                        FlutterFlowTheme.of(context).designToken.spacing.xs,
                        FlutterFlowTheme.of(context).designToken.spacing.md,
                        FlutterFlowTheme.of(context).designToken.spacing.xs),
                    child: GestureDetector(
                      onTap: () async {
                        // TODO: clear history
                        await _model.loadHistory();
                        _model.initHistoryItemModels(context);
                        safeSetState(() {});
                      },
                      child: Text(
                        'Clear All',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              lineHeight: 1.38,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Search bar
        Container(
          decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.lg,
                FlutterFlowTheme.of(context).designToken.spacing.md,
                FlutterFlowTheme.of(context).designToken.spacing.lg,
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.sm),
                border: Border.all(color: FlutterFlowTheme.of(context).outline, width: 1.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.sm),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Search your history...',
                          hintStyle: TextStyle(color: FlutterFlowTheme.of(context).hint),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                        validator: _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.sm)),
                ),
              ),
            ),
          ),
        ),
        // History list
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
            child: _model.status == SearchHistoryStatus.success
                ? _buildHistoryList(context)
                : _buildStatusBody(context, _model.status),
          ),
        ),
      ],
    );
  }
}
