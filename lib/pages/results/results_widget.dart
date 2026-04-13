import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/components/filter_chip_widget.dart';
import '/components/result_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'results_model.dart';
export 'results_model.dart';

class ResultsWidget extends StatefulWidget {
  const ResultsWidget({
    super.key,
    required this.imageFilePath,
  });

  final String imageFilePath;

  static String routeName = 'Results';
  static String routePath = '/results';

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  late ResultsModel vm;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSearchingImages = false;
  bool _isLoadingWebPages = false;
  String? _pendingImageUrl;

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
    if (_isSearchingImages) return;

    _isSearchingImages = true;
    try {
      await vm.search(context, widget.imageFilePath);
      if (mounted) safeSetState(() {});
    } finally {
      _isSearchingImages = false;
    }
  }

  Future<void> _selectImage(String imageUrl) async {
    if (_isLoadingWebPages) return;

    if (vm.selectedImageUrl == imageUrl && vm.status == ResultsStatus.webPagesLoaded) {
      return;
    }

    if (mounted) {
      safeSetState(() {
        _isLoadingWebPages = true;
        _pendingImageUrl = imageUrl;
        vm.selectedImageUrl = imageUrl;
        vm.status = ResultsStatus.loadingWebPages;
      });
    }

    try {
      await vm.selectImageAndLoadWebPages(context, imageUrl);
      if (mounted) safeSetState(() {});
    } finally {
      if (mounted) {
        safeSetState(() {
          _isLoadingWebPages = false;
          _pendingImageUrl = null;
        });
      }
    }
  }

  Future<void> _retry() async {
    if (_isSearchingImages || _isLoadingWebPages) return;
    await vm.retry(context, widget.imageFilePath);
    if (mounted) safeSetState(() {});
  }

  Widget _buildStatusBody(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    if (vm.status == ResultsStatus.loadingWebPages) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (vm.selectedImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
              child: SizedBox(
                height: 220.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: vm.selectedImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.secondaryBackground,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.secondaryBackground,
                        child: const Icon(Icons.broken_image_rounded),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.all(theme.designToken.spacing.md),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xCCFFFFFF),
                            borderRadius: BorderRadius.circular(
                              theme.designToken.radius.full,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0,
                              8.0,
                              16.0,
                              8.0,
                            ),
                            child: Text(
                              'Selected image',
                              style: theme.labelSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                ),
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
          const SizedBox(height: 16.0),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 12.0),
          Center(
            child: Text(
              'Fetching webpages...',
              style: theme.bodyMedium.override(
                font: GoogleFonts.outfit(),
                color: theme.secondaryText,
              ),
            ),
          ),
        ],
      );
    }

    final isLoading = vm.status == ResultsStatus.loadingImages || vm.status == ResultsStatus.initial;

    if (isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12.0),
            Text(
              'Searching for similar images...',
              style: theme.bodyMedium.override(
                font: GoogleFonts.outfit(),
                color: theme.secondaryText,
              ),
            ),
          ],
        ),
      );
    }

    if (vm.status == ResultsStatus.error) {
      return Center(
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
            TextButton(
              onPressed: _retry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSearchImagePreview(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
      child: SizedBox(
        height: 220.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(widget.imageFilePath),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: const AlignmentDirectional(-1.0, 1.0),
              child: Padding(
                padding: EdgeInsets.all(theme.designToken.spacing.md),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xCCFFFFFF),
                    borderRadius: BorderRadius.circular(theme.designToken.radius.full),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0,
                      8.0,
                      16.0,
                      8.0,
                    ),
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
    );
  }

  Widget _buildSimilarImages(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return SingleChildScrollView(
      primary: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchImagePreview(context),
          Text(
            '${vm.imageResults.length} visually similar images found',
            style: theme.bodyMedium.override(
              font: GoogleFonts.outfit(fontWeight: FontWeight.w500),
              color: theme.primaryText,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              lineHeight: 1.47,
            ),
          ),
          Text(
            'Select an image to find matching webpages.',
            style: theme.bodyMedium.override(
              font: GoogleFonts.outfit(),
              color: theme.secondaryText,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vm.imageResults.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final item = vm.imageResults[index];
              final isPending = _pendingImageUrl == item.imageUrl;

              return AbsorbPointer(
                absorbing: _isLoadingWebPages,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    theme.designToken.radius.lg,
                  ),
                  onTap: () => _selectImage(item.imageUrl),
                  child: Opacity(
                    opacity: _isLoadingWebPages && !isPending ? 0.6 : 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(theme.designToken.radius.lg),
                        border: Border.all(
                          color: theme.divider,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(theme.designToken.radius.lg),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: item.imageUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: theme.secondaryBackground,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: theme.secondaryBackground,
                                      child: const Icon(Icons.broken_image_rounded),
                                    ),
                                  ),
                                ),
                                if (isPending)
                                  Container(
                                    color: Colors.black26,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(theme.designToken.spacing.md),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    isPending ? 'Loading webpages...' : 'Use this image',
                                    style: theme.labelMedium.override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: theme.primaryText,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: theme.primaryText,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ].divide(SizedBox(height: theme.designToken.spacing.md)),
      ),
    );
  }

  Widget _buildWebPageResults(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    int modelIndex = 0;

    return SingleChildScrollView(
      primary: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (vm.selectedImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
              child: SizedBox(
                height: 220.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: vm.selectedImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.secondaryBackground,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.secondaryBackground,
                        child: const Icon(Icons.broken_image_rounded),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.all(theme.designToken.spacing.md),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xCCFFFFFF),
                            borderRadius: BorderRadius.circular(
                              theme.designToken.radius.full,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0,
                              8.0,
                              16.0,
                              8.0,
                            ),
                            child: Text(
                              'Selected image',
                              style: theme.labelSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                ),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  '${vm.webPageResults.length} webpages found',
                  style: theme.bodyMedium.override(
                    font: GoogleFonts.outfit(fontWeight: FontWeight.w500),
                    color: theme.primaryText,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    lineHeight: 1.47,
                  ),
                ),
              ),
              TextButton(
                onPressed: _isLoadingWebPages
                    ? null
                    : () {
                        vm.resetToImageSelection(context);
                        safeSetState(() {});
                      },
                child: const Text('Change image'),
              ),
            ],
          ),
          Row(
            children: [
              wrapWithModel(
                model: vm.filterChipModel1,
                updateCallback: () => safeSetState(() {}),
                child: const FilterChipWidget(
                  selected: true,
                  label: 'All',
                ),
              ),
              wrapWithModel(
                model: vm.filterChipModel2,
                updateCallback: () => safeSetState(() {}),
                child: const FilterChipWidget(
                  selected: false,
                  label: 'Web results',
                ),
              ),
            ].divide(SizedBox(width: theme.designToken.spacing.md)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < vm.webPageResults.length; i++)
                wrapWithModel(
                  model: vm.resultCardModels[modelIndex++],
                  updateCallback: () => safeSetState(() {}),
                  child: ResultCardWidget(
                    imgUrl: vm.webPageResults[i].imageUrl,
                    title: vm.webPageResults[i].domain,
                    url: vm.webPageResults[i].pageUrl,
                    type: _inferType(vm.webPageResults[i].domain),
                  ),
                ),
            ],
          ),
        ].divide(SizedBox(height: theme.designToken.spacing.md)),
      ),
    );
  }

  String _inferType(String domain) {
    final d = domain.toLowerCase();

    if (d.contains('instagram')) return 'Instagram';
    if (d.contains('tiktok')) return 'TikTok';
    if (d.contains('youtube') || d.contains('ytimg')) return 'YouTube';
    if (d.contains('reddit')) return 'Reddit';
    if (d.contains('jumia') || d.contains('tonaton')) return 'Marketplace';
    return 'Web page';
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.primaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.primaryText,
          ),
        ),
        title: Text(
          vm.status == ResultsStatus.webPagesLoaded ? 'Webpage Results' : 'Results',
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
      body: Padding(
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        child: switch (vm.status) {
          ResultsStatus.imagesLoaded => _buildSimilarImages(context),
          ResultsStatus.webPagesLoaded => _buildWebPageResults(context),
          _ => _buildStatusBody(context),
        },
      ),
    );
  }
}
