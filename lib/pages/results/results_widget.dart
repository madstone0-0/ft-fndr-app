import 'dart:io';
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
  const ResultsWidget({super.key, required this.imageFilePath});

  final String imageFilePath;

  static String routeName = 'Results';
  static String routePath = '/results';

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  late ResultsModel vm;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    vm = createModel(context, () => ResultsModel());

    _search();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    await vm.search(context, widget.imageFilePath);
    if (mounted) safeSetState(() {});
  }

  Widget _buildStatusBody(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return switch (vm.status) {
      ResultsStatus.loading || ResultsStatus.initial => const Center(child: CircularProgressIndicator()),
      ResultsStatus.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, color: theme.error, size: 48.0),
              const SizedBox(height: 12.0),
              Text(
                vm.errorMessage ?? 'Something went wrong.',
                style: theme.bodyMedium.override(
                  font: GoogleFonts.outfit(),
                  color: theme.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              TextButton(onPressed: _search, child: const Text('Retry')),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildResults(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final imageFilePath = widget.imageFilePath;
    int modelIndex = 0;

    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search image preview
          ClipRRect(
            borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(File(imageFilePath), fit: BoxFit.cover),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 1.0),
                    child: Padding(
                      padding: EdgeInsets.all(theme.designToken.spacing.md),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xCCFFFFFF),
                          borderRadius: BorderRadius.circular(theme.designToken.radius.full),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                          child: Text(
                            'Your search image',
                            style: theme.labelSmall.override(
                              font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                              color: theme.primaryText,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
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
            '${vm.results.length} results found',
            style: theme.bodyMedium.override(
              font: GoogleFonts.outfit(fontWeight: FontWeight.w500),
              color: theme.primaryText,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              lineHeight: 1.47,
            ),
          ),
          // Filter chips
          Row(
            children: [
              wrapWithModel(
                model: vm.filterChipModel1,
                updateCallback: () => safeSetState(() {}),
                child: const FilterChipWidget(selected: true, label: 'All'),
              ),
              wrapWithModel(
                model: vm.filterChipModel2,
                updateCallback: () => safeSetState(() {}),
                child: const FilterChipWidget(selected: false, label: 'Local first'),
              ),
            ].divide(SizedBox(width: theme.designToken.spacing.md)),
          ),
          // Results list
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < vm.results.length; i++)
                wrapWithModel(
                  model: vm.resultCardModels[modelIndex++],
                  updateCallback: () => safeSetState(() {}),
                  child: ResultCardWidget(
                    imgUrl: vm.results[i].imageUrl,
                    title: vm.results[i].domain,
                    url: vm.results[i].displayUrl,
                    type: _inferType(vm.results[i].domain),
                  ),
                ),
            ],
          ),
        ].divide(SizedBox(height: theme.designToken.spacing.md)),
      ),
    );
  }

  String _inferType(String domain) {
    if (domain.contains('instagram')) return 'Instagram';
    if (domain.contains('tiktok')) return 'TikTok';
    if (domain.contains('youtube') || domain.contains('ytimg')) return 'YouTube';
    if (domain.contains('reddit')) return 'Reddit';
    if (domain.contains('jumia') || domain.contains('tonaton')) return 'Marketplace';
    return 'Web page';
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      appBar:
        AppBar(
          backgroundColor: theme.primaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.primaryText),
          ),
          title: Text(
            'Results',
            style: theme.headlineMedium.override(
              font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
              color: theme.primaryText,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              lineHeight: 1.25,
            ),
          ),
          centerTitle: false,
          elevation: 0.0,
        ),
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(theme.designToken.spacing.lg),
              child: vm.status == ResultsStatus.success ? _buildResults(context) : _buildStatusBody(context),
            ),
          ),
        ],
      ),
    );
  }
}
