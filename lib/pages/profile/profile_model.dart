import '/flutter_flow/flutter_flow_model.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

import 'profile_widget.dart' show ProfileWidget;

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  // Form controllers for login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  FocusNode? loginEmailFocusNode;
  FocusNode? loginPasswordFocusNode;
  String? Function(BuildContext, String?)? loginEmailValidator;
  String? Function(BuildContext, String?)? loginPasswordValidator;

  // Form controllers for signup
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  FocusNode? signupNameFocusNode;
  FocusNode? signupEmailFocusNode;
  FocusNode? signupPasswordFocusNode;
  FocusNode? signupConfirmPasswordFocusNode;
  String? Function(BuildContext, String?)? signupNameValidator;
  String? Function(BuildContext, String?)? signupEmailValidator;
  String? Function(BuildContext, String?)? signupPasswordValidator;
  String? Function(BuildContext, String?)? signupConfirmPasswordValidator;

  // UI state
  bool isLoginMode = true; // true = login, false = signup
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

    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    signupNameFocusNode?.dispose();
    signupEmailFocusNode?.dispose();
    signupPasswordFocusNode?.dispose();
    signupConfirmPasswordFocusNode?.dispose();
  }

  void toggleMode() {
    isLoginMode = !isLoginMode;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
  }
}
