import 'package:ft_fndr_app/components/app_bar_widget.dart';
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
    _model.signupFNameFocusNode = FocusNode();
    _model.signupLNameFocusNode = FocusNode();
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
    if (mounted) setState(() {});
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration _fieldDecoration(
      BuildContext context,
      String label,
      String hint, {
        Widget? suffixIcon,
      }) {
    final theme = FlutterFlowTheme.of(context);
    final radius = BorderRadius.circular(theme.designToken.radius.sm);
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.outline, width: 1.0),
        borderRadius: radius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.primary, width: 2.0),
        borderRadius: radius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.error, width: 1.0),
        borderRadius: radius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.error, width: 2.0),
        borderRadius: radius,
      ),
    );
  }

  IconButton _visibilityToggle(bool isVisible, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: onPressed,
    );
  }

  FFButtonOptions _primaryButtonOptions(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return FFButtonOptions(
      width: double.infinity,
      height: 48.0,
      color: theme.primary,
      textStyle: theme.titleSmall.override(
        font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(theme.designToken.radius.sm),
    );
  }

  Future<void> _handleLogin() async {
    final email = _model.loginEmailController.text.trim();
    final password = _model.loginPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    final success = await _authNotifier.login(email, password);
    if (mounted && !success) {
      _showSnackBar(_authNotifier.errorMessage ?? 'Login failed');
    }
  }

  Future<void> _handleSignup() async {
    final fname = _model.signupFNameController.text.trim();
    final lname = _model.signupLNameController.text.trim();
    final email = _model.signupEmailController.text.trim();
    final password = _model.signupPasswordController.text;
    final confirmPassword = _model.signupConfirmPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all required fields');
      return;
    }
    if (password != confirmPassword) {
      _showSnackBar('Passwords do not match');
      return;
    }
    if (password.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return;
    }

    final success = await _authNotifier.signup(email, password, fname, lname);
    if (mounted && !success) {
      _showSnackBar(_authNotifier.errorMessage ?? 'Signup failed');
    }
  }

  Future<void> _handleLogout() async {
    await _authNotifier.logout();
  }

  Widget _buildAuthenticatedView(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final user = _authNotifier.user;
    final fullName = user?.userMetadata?.fullName;

    return Padding(
      padding: EdgeInsets.all(theme.designToken.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  if (fullName != null && fullName.isNotEmpty) ...[
                    Text(
                      fullName,
                      style: theme.titleMedium.override(
                        font: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                        color: theme.primaryText,
                      ),
                    ),
                    SizedBox(height: theme.designToken.spacing.xs),
                  ],
                  Text(
                    user?.email ?? '',
                    style: theme.bodyMedium.override(color: theme.secondaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isLoading = _authNotifier.status == AuthStatus.loading;

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
        TextFormField(
          controller: _model.loginEmailController,
          focusNode: _model.loginEmailFocusNode,
          decoration: _fieldDecoration(context, 'Email', 'Enter your email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: theme.designToken.spacing.md),
        TextFormField(
          controller: _model.loginPasswordController,
          focusNode: _model.loginPasswordFocusNode,
          obscureText: !_model.isPasswordVisible,
          decoration: _fieldDecoration(
            context,
            'Password',
            'Enter your password',
            suffixIcon: _visibilityToggle(
              _model.isPasswordVisible,
                  () => setState(() => _model.togglePasswordVisibility()),
            ),
          ),
        ),
        SizedBox(height: theme.designToken.spacing.lg),
        FFButtonWidget(
          onPressed: isLoading ? null : _handleLogin,
          text: isLoading ? 'Logging in...' : 'Login',
          options: _primaryButtonOptions(context),
        ),
        SizedBox(height: theme.designToken.spacing.md),
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
    final isLoading = _authNotifier.status == AuthStatus.loading;

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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _model.signupFNameController,
                  focusNode: _model.signupFNameFocusNode,
                  decoration: _fieldDecoration(context, 'First Name', 'First name'),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              SizedBox(width: theme.designToken.spacing.sm),
              Expanded(
                child: TextFormField(
                  controller: _model.signupLNameController,
                  focusNode: _model.signupLNameFocusNode,
                  decoration: _fieldDecoration(context, 'Last Name', 'Last name'),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.designToken.spacing.md),
          TextFormField(
            controller: _model.signupEmailController,
            focusNode: _model.signupEmailFocusNode,
            decoration: _fieldDecoration(context, 'Email', 'Enter your email'),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: theme.designToken.spacing.md),
          TextFormField(
            controller: _model.signupPasswordController,
            focusNode: _model.signupPasswordFocusNode,
            obscureText: !_model.isPasswordVisible,
            decoration: _fieldDecoration(
              context,
              'Password',
              'At least 6 characters',
              suffixIcon: _visibilityToggle(
                _model.isPasswordVisible,
                    () => setState(() => _model.togglePasswordVisibility()),
              ),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.md),
          TextFormField(
            controller: _model.signupConfirmPasswordController,
            focusNode: _model.signupConfirmPasswordFocusNode,
            obscureText: !_model.isConfirmPasswordVisible,
            decoration: _fieldDecoration(
              context,
              'Confirm Password',
              'Re-enter your password',
              suffixIcon: _visibilityToggle(
                _model.isConfirmPasswordVisible,
                    () => setState(() => _model.toggleConfirmPasswordVisibility()),
              ),
            ),
          ),
          SizedBox(height: theme.designToken.spacing.lg),
          FFButtonWidget(
            onPressed: isLoading ? null : _handleSignup,
            text: isLoading ? 'Creating account...' : 'Sign Up',
            options: _primaryButtonOptions(context),
          ),
          SizedBox(height: theme.designToken.spacing.md),
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

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.designToken.spacing.lg),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: _model.isLoginMode ? _buildLoginForm(context) : _buildSignupForm(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_authNotifier.status == AuthStatus.loading && _authNotifier.user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final isAuthed = _authNotifier.isAuthenticated;

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppPageBar(
        title: 'Profile',
        action: isAuthed
            ? AppPageBarAction(
          label: 'Logout',
          onTap: _handleLogout,
          color: FlutterFlowTheme.of(context).error,
        )
            : null,
      ),
      body: isAuthed ? _buildAuthenticatedView(context) : _buildUnauthenticatedView(context),
    );
  }
}
