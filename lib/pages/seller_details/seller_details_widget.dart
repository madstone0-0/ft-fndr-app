import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seller_details_model.dart';
export 'seller_details_model.dart';

class SellerDetailsWidget extends StatefulWidget {
  const SellerDetailsWidget({super.key});

  static String routeName = 'SellerDetails';
  static String routePath = '/sellerDetails';

  @override
  State<SellerDetailsWidget> createState() => _SellerDetailsWidgetState();
}

class _SellerDetailsWidgetState extends State<SellerDetailsWidget> {
  late SellerDetailsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerDetailsModel());
    _model.loadSeller();
    final seller = _model.seller;
    if (seller != null) {
      _model.initProductModels(context, seller.featuredProducts.length);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildContactAction(BuildContext context, SellerContactAction action) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: action.url != null ? () async => await launchURL(action.url!) : null,
            child: Container(
              width: 52.0,
              height: 52.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.full),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).divider,
                  width: 1.0,
                ),
              ),
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Icon(action.icon, color: FlutterFlowTheme.of(context).primary, size: 24.0),
            ),
          ),
          Text(
            action.label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.27,
                ),
          ),
        ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SellerData seller) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, FlutterFlowTheme.of(context).designToken.spacing.xl),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero image
            ClipRRect(
              child: SizedBox(
                height: 300.0,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      imageUrl: seller.coverImageUrl,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0x9916120D), Colors.transparent],
                          stops: [0.0, 0.6],
                          begin: AlignmentDirectional(0.0, 1.0),
                          end: AlignmentDirectional(0, -1.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Seller info card
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0,
                  FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                ),
                child: Padding(
                  padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 64.0,
                            height: 64.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              shape: BoxShape.circle,
                            ),
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              seller.avatarInitials,
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                fontWeight: FontWeight.w600,
                                fontSize: 25.6,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      seller.name,
                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                            font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            lineHeight: 1.27,
                                          ),
                                    ),
                                    if (seller.isVerified)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).success,
                                          borderRadius: BorderRadius.circular(
                                              FlutterFlowTheme.of(context).designToken.radius.full),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 2.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.verified_rounded,
                                                  color: FlutterFlowTheme.of(context).primaryText, size: 12.0),
                                              Text(
                                                'Verified',
                                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                                      font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 11.0,
                                                      fontWeight: FontWeight.w600,
                                                      lineHeight: 1.27,
                                                    ),
                                              ),
                                            ].divide(const SizedBox(width: 4.0)),
                                          ),
                                        ),
                                      ),
                                  ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                                ),
                                Text(
                                  seller.location,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.outfit(fontWeight: FontWeight.normal),
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal,
                                        lineHeight: 1.47,
                                      ),
                                ),
                              ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
                            ),
                          ),
                        ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.md)),
                      ),
                      Divider(color: FlutterFlowTheme.of(context).divider),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            FlutterFlowTheme.of(context).designToken.spacing.sm,
                            0.0,
                            FlutterFlowTheme.of(context).designToken.spacing.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: seller.contactActions.map((a) => _buildContactAction(context, a)).toList(),
                        ),
                      ),
                    ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md)),
                  ),
                ),
              ),
            ),
            // About
            Padding(
              padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About the Brand',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.35,
                          )),
                  Text(
                    seller.about,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.outfit(fontWeight: FontWeight.normal),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          lineHeight: 1.5,
                        ),
                  ),
                ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.sm)),
              ),
            ),
            // Featured collection
            if (seller.featuredProducts.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0,
                        FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Featured Collection',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.35,
                                )),
                        Text('View All',
                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                  font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.33,
                                )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0,
                        FlutterFlowTheme.of(context).designToken.spacing.lg, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < seller.featuredProducts.length; i++)
                            wrapWithModel(
                              model: _model.productCardModels[i],
                              updateCallback: () => safeSetState(() {}),
                              child: ProductCardWidget(
                                img_desc: seller.featuredProducts[i].imgDesc,
                                name: seller.featuredProducts[i].name,
                                price: seller.featuredProducts[i].price,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md)),
              ),
            // Store location
            Padding(
              padding: EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Store Location',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.35,
                          )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                    child: Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(FlutterFlowTheme.of(context).designToken.radius.lg),
                        border: Border.all(color: FlutterFlowTheme.of(context).divider, width: 1.0),
                      ),
                      child: SizedBox(
                        width: 300.0,
                        height: 200.0,
                        child: FlutterFlowGoogleMap(
                          controller: _model.googleMapsController,
                          onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                          initialLocation: _model.googleMapsCenter ??= seller.storeLatLng,
                          markerColor: GoogleMarkerColor.violet,
                          mapType: MapType.normal,
                          style: GoogleMapStyle.standard,
                          initialZoom: 15.0,
                          allowInteraction: true,
                          allowZoom: true,
                          showZoomControls: false,
                          showLocation: false,
                          showCompass: false,
                          showMapToolbar: false,
                          showTraffic: false,
                          centerMapOnMarkerTap: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, FlutterFlowTheme.of(context).designToken.spacing.sm,
                        0.0, FlutterFlowTheme.of(context).designToken.spacing.sm),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 18.0),
                        Text(
                          seller.storeAddress,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.outfit(fontWeight: FontWeight.normal),
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                lineHeight: 1.38,
                              ),
                        ),
                      ].divide(SizedBox(width: FlutterFlowTheme.of(context).designToken.spacing.sm)),
                    ),
                  ),
                ].divide(SizedBox(height: FlutterFlowTheme.of(context).designToken.spacing.md)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBody(BuildContext context, SellerDetailsStatus status) {
    return switch (status) {
      SellerDetailsStatus.loading || SellerDetailsStatus.initial => const Center(
          child: CircularProgressIndicator(),
        ),
      SellerDetailsStatus.error => Center(
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
                onPressed: () => _model.loadSeller(),
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
    final vm = _model;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Stack(
        children: [
          vm.status == SellerDetailsStatus.success && vm.seller != null
              ? _buildBody(context, vm.seller!)
              : _buildStatusBody(context, vm.status),
          // Blurred top nav
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: SizedBox(
              height: 100.0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: const BoxDecoration(),
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          FlutterFlowTheme.of(context).designToken.spacing.lg,
                          FlutterFlowTheme.of(context).designToken.spacing.md,
                          FlutterFlowTheme.of(context).designToken.spacing.lg,
                          FlutterFlowTheme.of(context).designToken.spacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: FlutterFlowTheme.of(context).designToken.radius.full,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            icon: Icon(Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).primaryText, size: 24.0),
                            onPressed: () => context.safePop(),
                          ),
                          Text('Seller Info',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.35,
                                  )),
                          FlutterFlowIconButton(
                            borderRadius: FlutterFlowTheme.of(context).designToken.radius.full,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            icon:
                                Icon(Icons.share_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 24.0),
                            onPressed: () async => await launchURL('https://ftfndr.com'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
