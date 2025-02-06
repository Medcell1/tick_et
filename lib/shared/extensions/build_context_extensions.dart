import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

extension CustomBuildContextExtensions on BuildContext {
  // Returns the MediaQueryData object for the current BuildContext
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // Returns the Size object for the current BuildContext
  Size get size => mediaQuery.size;

  // Returns the width of the current BuildContext
  double get width => mediaQuery.size.width;

  // Returns the height of the current BuildContext
  double get height => mediaQuery.size.height;

  // Returns the bottom padding of the current BuildContext
  double get bottomPadding => mediaQuery.padding.bottom;

  // Returns the top padding of the current BuildContext
  double get topPadding => mediaQuery.padding.top;

  // Returns the ThemeData object for the current BuildContext
  ThemeData get theme => Theme.of(this);

  T? args<T>() {
    return ModalRoute.of(this)?.settings.arguments as T?;
  }

  bool isFormDisabled(String formControlName) {
    return reactiveFormGroup!.control(formControlName).disabled;
  }

  bool formValueHasError(String formControlName) {
    return reactiveFormGroup!.control(formControlName).touched &&
        reactiveFormGroup!.control(formControlName).hasErrors;
  }

  bool get isMobile => MediaQuery.of(this).size.width < 450;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 450 &&
      MediaQuery.of(this).size.width < 720;
  bool get isDesktop => MediaQuery.of(this).size.width >= 720;

  T? formValue<T>(String name) {
    return (reactiveForm?.value as Map<String, dynamic>?)?[name];
  }

  AbstractControl? get reactiveForm => ReactiveForm.of(this);
  FormGroup? get reactiveFormGroup => ReactiveForm.of(this) as FormGroup?;

  Future<dynamic> goCrazy({
    required String desktop,
    required String mobile,
    required Map<String, dynamic> params,
    dynamic extra,
  }) async {
    if (isDesktop) {
      goNamed(desktop, queryParameters: params, extra: extra);
      return null;
    } else {
      return pushNamed(mobile, queryParameters: params, extra: extra);
    }
  }

  GoRouterState? get routerState {
    try {
      return GoRouterState.of(this);
    } catch (e) {
      return null;
    }
  }

  GoRouter get router => GoRouter.of(this);
}
