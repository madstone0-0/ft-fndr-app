import 'dart:io';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';
import 'package:ft_fndr_app/services/Locator.dart';

import '/components/recent_search_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  late AuthNotifier _authNotifier;
  late bool loggedIn;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
    _authNotifier = getIt<AuthNotifier>();

    loggedIn = _authNotifier.isAuthenticated;
    _authNotifier.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    _model.dispose();
    _authNotifier.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (!mounted) return;

    if (_authNotifier.isAuthenticated) {
      setState(() {
        loggedIn = true;
      });
    } else {
      setState(() {
        loggedIn = false;
      });
    }
  }

  Future<void> _navigateToResults(String imagePath) async {
    if (!mounted) return;
    context.pushNamed(
      'Results',
      extra: <String, dynamic>{'imageFilePath': imagePath},
    );
  }

  Future<void> _openCameraSearch() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) await _navigateToResults(pickedFile.path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open camera. Please check camera permissions.')),
        );
      }
    }
  }

  Future<void> _openGallerySearch() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) await _navigateToResults(pickedFile.path);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open gallery. Please check photo permissions.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            theme.designToken.spacing.lg,
            theme.designToken.spacing.md,
            theme.designToken.spacing.lg,
            theme.designToken.spacing.md,
          ),
          child: Text(
            'Ft Fndr',
            style: theme.headlineMedium.override(
              font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
              color: theme.primaryText,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              lineHeight: 1.25,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Camera search button
                GestureDetector(
                  onTap: () {
                    // If is authed allow camera access, otherwise prompt to log in
                    if (loggedIn) {
                      _openCameraSearch();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please log in to use camera search.')),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(theme.designToken.spacing.lg),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
                      child: Container(
                        height: 360.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16120D),
                          borderRadius: BorderRadius.circular(theme.designToken.radius.xl),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(theme.designToken.radius.lg),
                                      border: Border.all(color: theme.accent1, width: 3.0),
                                    ),
                                  ),
                                  Text(
                                    'Point at any item',
                                    style: theme.titleLarge.override(
                                      font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w500),
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.27,
                                    ),
                                  ),
                                  Container(
                                    width: 72.0,
                                    height: 72.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(theme.designToken.radius.full),
                                      border: Border.all(color: const Color(0xCCFFFFFF), width: 4.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: theme.accent1,
                                          borderRadius: BorderRadius.circular(theme.designToken.radius.full),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: theme.designToken.spacing.lg)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Upload / Paste URL buttons
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    theme.designToken.spacing.lg,
                    0.0,
                    theme.designToken.spacing.lg,
                    0.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (loggedIn) {
                              _openGallerySearch();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please log in to upload photos.')),
                              );
                            }
                          },
                          child: _buildActionButton(
                            context,
                            icon: Icons.north_rounded,
                            label: 'Upload photo',
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: theme.designToken.spacing.md)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label}) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(theme.designToken.radius.lg),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          theme.designToken.spacing.xl,
          theme.designToken.spacing.md,
          theme.designToken.spacing.xl,
          theme.designToken.spacing.md,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.primaryBackground, size: 16.0),
            Text(
              label,
              style: theme.labelMedium.override(
                font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                color: theme.primaryBackground,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                lineHeight: 1.38,
              ),
            ),
          ].divide(const SizedBox(width: 8.0)),
        ),
      ),
    );
  }
}
