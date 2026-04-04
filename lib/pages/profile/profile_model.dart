import '/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';
import 'profile_widget.dart' show ProfileWidget;

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  // Login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  FocusNode? loginEmailFocusNode;
  FocusNode? loginPasswordFocusNode;
  String? Function(BuildContext, String?)? loginEmailValidator;
  String? Function(BuildContext, String?)? loginPasswordValidator;

  // Signup
  final signupFNameController = TextEditingController();
  final signupLNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  FocusNode? signupFNameFocusNode;
  FocusNode? signupLNameFocusNode;
  FocusNode? signupEmailFocusNode;
  FocusNode? signupPasswordFocusNode;
  FocusNode? signupConfirmPasswordFocusNode;
  String? Function(BuildContext, String?)? signupFNameValidator;
  String? Function(BuildContext, String?)? signupLNameValidator;
  String? Function(BuildContext, String?)? signupEmailValidator;
  String? Function(BuildContext, String?)? signupPasswordValidator;
  String? Function(BuildContext, String?)? signupConfirmPasswordValidator;

  // UI state
  bool isLoginMode = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginEmailFocusNode?.dispose();
    loginPasswordFocusNode?.dispose();

    signupFNameController.dispose();
    signupLNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    signupFNameFocusNode?.dispose();
    signupLNameFocusNode?.dispose(); // was missing
    signupEmailFocusNode?.dispose();
    signupPasswordFocusNode?.dispose();
    signupConfirmPasswordFocusNode?.dispose();
  }

  void toggleMode() => isLoginMode = !isLoginMode;

  void togglePasswordVisibility() => isPasswordVisible = !isPasswordVisible;

  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible = !isConfirmPasswordVisible;
}
