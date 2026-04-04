import 'package:ft_fndr_app/providers/AuthNotifier.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/Locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static String routeName = 'Profile';
  static String routePath = '/profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;
  late AuthNotifier _authNotifier;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());
    _authNotifier = getIt<AuthNotifier>();
    _authNotifier.addListener(_onAuthStateChanged);

    _model.loginEmailFocusNode = FocusNode();
    _model.loginPasswordFocusNode = FocusNode();
    _model.signupNameFocusNode = FocusNode();
    _model.signupEmailFocusNode = FocusNode();
    _model.signupPasswordFocusNode = FocusNode();
    _model.signupConfirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _authNotifier.removeListener(_onAuthStateChanged);
    _model.dispose();
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleLogin() async {
    final email = _model.loginEmailController.text.trim();
    final password = _model.loginPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final success = await _authNotifier.login(email, password);
    if (mounted && !success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authNotifier.errorMessage ?? 'Login failed')),
      );
    }
  }

  Future<void> _handleSignup() async {
    final name = _model.signupNameController.text.trim();
    final email = _model.signupEmailController.text.trim();
    final password = _model.signupPasswordController.text;
    final confirmPassword = _model.signupConfirmPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    final success = await _authNotifier.signup(email, password, name.isEmpty ? null : name);
    if (mounted && !success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authNotifier.errorMessage ?? 'Signup failed')),
      );
    }
  }

  Future<void> _handleLogout() async {
    await _authNotifier.logout();
  }

  Widget _buildAuthenticatedView(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final user = _authNotifier.user;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          decoration: BoxDecoration(color: theme.secondaryBackground),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              theme.designToken.spacing.lg,
              theme.designToken.spacing.md,
              theme.designToken.spacing.lg,
              theme.designToken.spacing.md,
            ),
            child: Text(
              'Profile',
              style: theme.headlineMedium.override(
                font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                color: theme.primaryText,
                fontSize: 28.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                lineHeight: 1.25,
              ),
            ),
          ),
        ),
        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(theme.designToken.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(theme.designToken.radius.md),
                    border: Border.all(color: theme.outline, width: 1.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(theme.designToken.spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.person_rounded, size: 48.0, color: theme.primary),
                        SizedBox(height: theme.designToken.spacing.md),
                        if (user?.name != null && user!.name!.isNotEmpty) ...[
                          Text(
                            user.name!,
                            style: theme.headlineSmall.override(
                              font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: theme.designToken.spacing.xs),
                        ],
                        Text(
                          user?.email ?? '',
                          style: theme.bodyMedium.override(
                            color: theme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: theme.designToken.spacing.xl),
                // Logout button
                FFButtonWidget(
                  onPressed: _handleLogout,
                  text: 'Logout',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48.0,
                    color: theme.error,
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
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Login',
          style: theme.headlineSmall.override(
            font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: theme.designToken.spacing.lg),
        // Email field
        TextFormField(
          controller: _model.loginEmailController,
          focusNode: _model.loginEmailFocusNode,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.outline, width: 1.0),
              borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 2.0),
              borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: theme.designToken.spacing.md),
        // Password field
        TextFormField(
          controller: _model.loginPasswordController,
          focusNode: _model.loginPasswordFocusNode,
          obscureText: !_model.isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.outline, width: 1.0),
              borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 2.0),
              borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
            ),
            suffixIcon: IconButton(
              icon: Icon(_model.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _model.togglePasswordVisibility()),
            ),
          ),
        ),
        SizedBox(height: theme.designToken.spacing.lg),
        // Login button
        FFButtonWidget(
          onPressed: _authNotifier.status == AuthStatus.loading ? null : _handleLogin,
          text: _authNotifier.status == AuthStatus.loading ? 'Logging in...' : 'Login',
          options: FFButtonOptions(
            width: double.infinity,
            height: 48.0,
            color: theme.primary,
            textStyle: theme.titleSmall.override(
              font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
          ),
        ),
        SizedBox(height: theme.designToken.spacing.md),
        // Switch to signup
        Center(
          child: GestureDetector(
            onTap: () => setState(() => _model.toggleMode()),
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: theme.bodyMedium.override(color: theme.secondaryText),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: theme.bodyMedium.override(
                      color: theme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign Up',
            style: theme.headlineSmall.override(
              font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: theme.designToken.spacing.lg),
          // Name field
          TextFormField(
            controller: _model.signupNameController,
            focusNode: _model.signupNameFocusNode,
            decoration: InputDecoration(
              labelText: 'Name (optional)',
              hintText: 'Enter your name',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.outline, width: 1.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 2.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.md),
          // Email field
          TextFormField(
            controller: _model.signupEmailController,
            focusNode: _model.signupEmailFocusNode,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.outline, width: 1.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 2.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: theme.designToken.spacing.md),
          // Password field
          TextFormField(
            controller: _model.signupPasswordController,
            focusNode: _model.signupPasswordFocusNode,
            obscureText: !_model.isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'At least 6 characters',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.outline, width: 1.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 2.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              suffixIcon: IconButton(
                icon: Icon(_model.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _model.togglePasswordVisibility()),
              ),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.md),
          // Confirm password field
          TextFormField(
            controller: _model.signupConfirmPasswordController,
            focusNode: _model.signupConfirmPasswordFocusNode,
            obscureText: !_model.isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.outline, width: 1.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 2.0),
                borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
              ),
              suffixIcon: IconButton(
                icon: Icon(_model.isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _model.toggleConfirmPasswordVisibility()),
              ),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.lg),
          // Signup button
          FFButtonWidget(
            onPressed: _authNotifier.status == AuthStatus.loading ? null : _handleSignup,
            text: _authNotifier.status == AuthStatus.loading ? 'Creating account...' : 'Sign Up',
            options: FFButtonOptions(
              width: double.infinity,
              height: 48.0,
              color: theme.primary,
              textStyle: theme.titleSmall.override(
                font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.md),
          // Switch to login
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _model.toggleMode()),
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: theme.bodyMedium.override(color: theme.secondaryText),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: theme.bodyMedium.override(
                        color: theme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedView(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          decoration: BoxDecoration(color: theme.secondaryBackground),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              theme.designToken.spacing.lg,
              theme.designToken.spacing.md,
              theme.designToken.spacing.lg,
              theme.designToken.spacing.md,
            ),
            child: Text(
              'Profile',
              style: theme.headlineMedium.override(
                font: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
                color: theme.primaryText,
                fontSize: 28.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                lineHeight: 1.25,
              ),
            ),
          ),
        ),
        // Auth forms
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(theme.designToken.spacing.lg),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _model.isLoginMode ? _buildLoginForm(context) : _buildSignupForm(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_authNotifier.status == AuthStatus.loading && _authNotifier.user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return _authNotifier.isAuthenticated
        ? _buildAuthenticatedView(context)
        : _buildUnauthenticatedView(context);
  }
}
