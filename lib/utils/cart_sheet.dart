import 'package:flutter/material.dart';
import 'snackbar_helper.dart';
import '../models/instrumento.dart';

class CartSheet extends StatelessWidget {
  final List<ArticuloCarrito> cartItems;
  final double total;
  final Function(ArticuloCarrito, int) onUpdateQuantity;

  const CartSheet({
    super.key,
    required this.cartItems,
    required this.total,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen =
        mediaQuery.size.width < 380; // Pantallas muy estrechas

    // Define un padding basado en el tamaño de la pantalla
    final double horizontalPadding = isSmallScreen ? 12 : 20;
    final double verticalPadding = isSmallScreen ? 15 : 20;

    return Column(
      children: [
        // Header
        Padding(
          padding: EdgeInsets.only(
            top: verticalPadding,
            bottom: 10,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mi Carrito',
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Lista de Artículos
        Expanded(
          child: cartItems.isEmpty
              ? Center(
                  child: Text(
                    'El carrito está vacío.',
                    style: theme.textTheme.titleMedium,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 16,
                  ),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return _buildCartItemTile(theme, item, isSmallScreen);
                  },
                ),
        ),
        const Divider(height: 1),

        // Resumen y Botón de Pago
        Container(
          padding: EdgeInsets.all(verticalPadding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fila del Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botón de Comprar Ahora
              ElevatedButton(
                onPressed: cartItems.isNotEmpty
                    ? () {
                        // Simulación de proceso de pago
                        Navigator.pop(context);
                        showFloatingSnackBar(
                          context,
                          '¡Compra simulada realizada con éxito!',
                          backgroundColor: Colors.green,
                        );
                      }
                    : null, // Deshabilitar si el carrito está vacío
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Comprar Ahora',
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemTile(
    ThemeData theme,
    ArticuloCarrito item,
    bool isSmallScreen,
  ) {
    // Reduce el tamaño de la imagen y la fuente en pantallas muy pequeñas
    final double imageSize = isSmallScreen ? 60 : 70;
    final double titleFontSize = isSmallScreen
        ? theme.textTheme.titleSmall!.fontSize!
        : theme.textTheme.titleMedium!.fontSize!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen del Artículo
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.surface,
            ),
            child: Image.network(
              item.instrumento.imagenUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.music_note_outlined,
                size: imageSize * 0.6,
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Detalles del Artículo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.instrumento.nombre,
                  style: theme.textTheme
                      .copyWith(
                        titleMedium: theme.textTheme.titleMedium!.copyWith(
                          fontSize: titleFontSize,
                        ),
                      )
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.instrumento.fabricante,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(item.instrumento.precio * item.cantidad).toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Control de Cantidad
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Aumentar
                _buildQuantityButton(
                  icon: Icons.add,
                  onPressed: () => onUpdateQuantity(item, item.cantidad + 1),
                  theme: theme,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  child: Text(
                    item.cantidad.toString(),
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Disminuir
                _buildQuantityButton(
                  icon: Icons.remove,
                  onPressed: () => onUpdateQuantity(item, item.cantidad - 1),
                  theme: theme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, size: 20, color: theme.colorScheme.primary),
      ),
    );
  }
}
