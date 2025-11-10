import 'package:flutter/material.dart';

import 'screens/login_page.dart';
import 'screens/main_catalog_screen.dart';

// --- MAIN APP ---

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de colores principales
    const Color primaryColor = Color(
      0xFF6C63FF,
    ); // Púrpura/Índigo para el acento
    const Color accentColor = Color(0xFFEE8795); // Rosa Suave para botones

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Store',
      theme: ThemeData(
        // Usamos el textTheme por defecto del sistema para evitar el error de dependencia.
        // (Se eliminó la referencia a GoogleFonts.interTextTheme)
        colorScheme:
            ColorScheme.fromSwatch(
              primarySwatch:
                  MaterialColor(primaryColor.toARGB32(), <int, Color>{
                    50: primaryColor.withValues(alpha: 0.1),
                    100: primaryColor.withValues(alpha: 0.2),
                    200: primaryColor.withValues(alpha: 0.25),
                    300: primaryColor.withValues(alpha: 0.4),
                    400: primaryColor.withValues(alpha: 0.5),
                    500: primaryColor,
                    600: primaryColor.withValues(alpha: 0.6),
                    700: primaryColor.withValues(alpha: 0.7),
                    800: primaryColor.withValues(alpha: 0.8),
                    900: primaryColor.withValues(alpha: 0.9),
                  }),
            ).copyWith(
              secondary: accentColor,
              surface: const Color(0xFFF5F5F5), // Fondo suave
            ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/catalog': (context) => const MainCatalogScreen(),
      },
    );
  }
}
