import 'package:flutter/material.dart';
import '../models/instrumento.dart';

class DetallesInstrumentoPage extends StatelessWidget {
  final Instrumento instrumento;
  final Function(Instrumento) onAddToCart;

  const DetallesInstrumentoPage({
    super.key,
    required this.instrumento,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isLargeScreen = mediaQuery.size.width > 800;

    // Altura de imagen adaptable: más pequeña en pantallas grandes (para dejar espacio a los detalles)
    final double imageHeight = isLargeScreen ? 250 : 300;
    // Padding horizontal adaptable: más grande en pantallas grandes para centrar el contenido
    final double horizontalPadding = isLargeScreen ? 100 : 20;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          instrumento.nombre,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 100,
            ), // Espacio para la barra inferior
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección de Imagen
                Container(
                  width: double.infinity,
                  height: imageHeight, // Altura adaptable
                  color: Colors.white,
                  child: Center(
                    child: Hero(
                      tag: 'instrument-${instrumento.nombre}',
                      child: Image.network(
                        instrumento.imagenUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.music_note_outlined,
                          size: 150,
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sección de Detalles
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ), // Padding adaptable
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fabricante: ${instrumento.fabricante}',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Card de Detalles
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detalles del Instrumento',
                              style: theme.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            Text(
                              instrumento.detalles,
                              style: theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            // Detalles técnicos simulados
                            _buildDetailRow(
                              'Categoría',
                              instrumento.categoria,
                              theme,
                            ),
                            _buildDetailRow(
                              'Material',
                              'Madera de Arce/Caoba',
                              theme,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Botón de Añadir a Carrito (Fijo en la parte inferior)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${instrumento.precio.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      onAddToCart(instrumento);
                      Navigator.pop(context); // Regresar al catálogo
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Añadir al Carrito',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
