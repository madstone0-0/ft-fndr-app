import 'package:ft_fndr_app/components/app_bar_widget.dart';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';

import '/components/history_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/Locator.dart';
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
  late AuthNotifier _authNotifier;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchHistoryModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _authNotifier = getIt<AuthNotifier>();
    _authNotifier.addListener(_onAuthStateChanged);

    if (_authNotifier.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadHistory();
      });
    }
  }

  @override
  void dispose() {
    _authNotifier.removeListener(_onAuthStateChanged);
    _model.dispose();
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (!mounted) return;

    if (_authNotifier.isAuthenticated) {
      _loadHistory();
    } else {
      setState(() {
        _model.status = SearchHistoryStatus.initial;
        _model.historyGroups = [];
        _model.errorMessage = null;
      });
    }
  }

  Future<void> _loadHistory() async {
    await _model.loadHistory(context);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _refresh() async {
    if (!_authNotifier.isAuthenticated) return;
    await _loadHistory();
  }

  Future<void> _clearAll() async {
    await _model.clearHistory(context);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      color: theme.primaryBackground,
      padding: EdgeInsetsDirectional.fromSTEB(
        theme.designToken.spacing.lg,
        theme.designToken.spacing.md,
        theme.designToken.spacing.lg,
        theme.designToken.spacing.md,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
          border: Border.all(
            color: theme.outline,
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.all(theme.designToken.spacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: theme.primaryText,
              size: 16.0,
            ),
            Expanded(
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Search your history...',
                  hintStyle: TextStyle(color: theme.hint),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  isDense: true,
                ),
                style: TextStyle(color: theme.primaryText),
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
          ].divide(SizedBox(width: theme.designToken.spacing.sm)),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: theme.designToken.spacing.md),
      child: Text(
        label,
        style: theme.labelLarge.override(
          font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
          color: theme.primaryText,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          lineHeight: 1.33,
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    int modelIndex = 0;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        children: [
          for (int g = 0; g < _model.historyGroups.length; g++) ...[
            if (g > 0) SizedBox(height: theme.designToken.spacing.md),
            _buildSectionLabel(context, _model.historyGroups[g].label),
            for (final item in _model.historyGroups[g].items)
              wrapWithModel(
                model: _model.historyItemModels[modelIndex++],
                updateCallback: () => setState(() {}),
                child: HistoryItemWidget(
                  onDelete: () async {
                    await _model.deleteHistoryItem(context, item.id);
                    setState(() {});
                  },
                  onBookmark: () async {
                    await _model.bookmarkHistoryItem(context, item.id);
                    setState(() {});
                  },
                  imgUrl: item.imgUrl,
                  title: item.title,
                  timestamp: item.timestamp.toString(),
                ),
              ),
          ],
          if (_model.historyGroups.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history_outlined, size: 64.0, color: theme.secondaryText),
                  SizedBox(height: theme.designToken.spacing.lg),
                  Text(
                    'No history yet',
                    style: theme.headlineSmall.override(
                      font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: theme.designToken.spacing.sm),
                  Text(
                    'Your recent searches will appear here.',
                    style: theme.bodyMedium.override(color: theme.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildStatusBody(BuildContext context, SearchHistoryStatus status) {
    final theme = FlutterFlowTheme.of(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.2),
          switch (status) {
            SearchHistoryStatus.loading ||
            SearchHistoryStatus.initial =>
            const Center(child: CircularProgressIndicator()),
            SearchHistoryStatus.error =>
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: theme.error,
                        size: 48.0,
                      ),
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
                        onPressed: _loadHistory,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.15),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 64.0,
                  color: theme.secondaryText,
                ),
                SizedBox(height: theme.designToken.spacing.lg),
                Text(
                  'Sign in to view your history',
                  style: theme.headlineSmall.override(
                    font: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.w600,
                    ),
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.designToken.spacing.sm),
                Text(
                  'Your search history will be saved and synced across devices when you log in.',
                  style: theme.bodyMedium.override(
                    color: theme.secondaryText,
                  ),
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
                    borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchBar(context),
        Expanded(
          child: _model.status == SearchHistoryStatus.success
              ? _buildHistoryList(context)
              : _buildStatusBody(context, _model.status),
        ),
      ],
    );
  }

  Widget _buildSignedOutBody(BuildContext context) {
    return _buildLoginPrompt(context);
  }

  @override
  Widget build(BuildContext context) {
    final isAuthed = _authNotifier.isAuthenticated;

    return Scaffold(
      backgroundColor: FlutterFlowTheme
          .of(context)
          .primaryBackground,
      appBar: AppPageBar(
        title: 'Search History',
        action: isAuthed
            ? AppPageBarAction(
          label: 'Clear All',
          onTap: _clearAll,
          color: FlutterFlowTheme
              .of(context)
              .primary,
        )
            : null,
      ),
      body: isAuthed ? _buildAuthenticatedBody(context) : _buildSignedOutBody(context),
    );
  }
}
