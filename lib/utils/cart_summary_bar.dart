import 'package:flutter/material.dart';
import 'snackbar_helper.dart';

class CartSummaryBar extends StatelessWidget {
  final int totalItems;
  final double totalPrice;

  const CartSummaryBar({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (totalItems == 0) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: <Widget>[
          // Total de Artículos y Precio
          RichText(
            text: TextSpan(
              style: theme.textTheme.titleMedium!.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: '$totalItems Artículo${totalItems > 1 ? 's' : ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' | ',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                TextSpan(
                  text: '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Botón Ver Carrito
          TextButton(
            onPressed: () {
              showFloatingSnackBar(
                context,
                'Usa el botón del carrito para ver los detalles.',
                backgroundColor: theme.colorScheme.secondary,
                duration: const Duration(seconds: 2),
              );
            },
            child: Text(
              'Ver Carrito',
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
