import 'package:flutter/material.dart';

/// Muestra un SnackBar flotante y no obstruyente.
///
/// Usa `SnackBarBehavior.floating` y un margin que aleja el SnackBar de
/// la parte inferior para que no tape barras/elementos fijos.
void showFloatingSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 2),
}) {
  final mediaQuery = MediaQuery.of(context);
  // Separación mínima desde la parte inferior para evitar barras fijas.
  final double bottomMargin = 100 + mediaQuery.viewInsets.bottom;

  final snackBar = SnackBar(
    content: Text(message),
    duration: duration,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.fromLTRB(16, 16, 16, bottomMargin),
    backgroundColor: backgroundColor,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
