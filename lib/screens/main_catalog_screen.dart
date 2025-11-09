import 'package:flutter/material.dart';
import '../data/instrumentos_data.dart';
import '../models/instrumento.dart';
import '../utils/instrumento_tile.dart';
import '../utils/cart_summary_bar.dart';
import '../utils/cart_sheet.dart';
import '../utils/snackbar_helper.dart';

class MainCatalogScreen extends StatefulWidget {
  const MainCatalogScreen({super.key});

  @override
  State<MainCatalogScreen> createState() => _MainCatalogScreenState();
}

class _MainCatalogScreenState extends State<MainCatalogScreen> {
  final List<ArticuloCarrito> _cartItems = [];

  void _addToCart(Instrumento instrumento) {
    setState(() {
      final existingItem = _cartItems.firstWhere(
        (item) => item.instrumento.nombre == instrumento.nombre,
        orElse: () => ArticuloCarrito(instrumento: instrumento, cantidad: 0),
      );

      if (existingItem.cantidad > 0) {
        existingItem.cantidad++;
      } else {
        _cartItems.add(ArticuloCarrito(instrumento: instrumento));
      }
    });
    // Pequeño feedback visual (no obstruyente)
    // Usamos un SnackBar flotante para que no tape la barra inferior
    // ni otros elementos fijos.
    showFloatingSnackBar(
      context,
      '"${instrumento.nombre}" añadido al carrito.',
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(milliseconds: 1000),
    );
  }

  void _updateCartQuantity(ArticuloCarrito item, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeWhere(
          (i) => i.instrumento.nombre == item.instrumento.nombre,
        );
      } else {
        item.cantidad = newQuantity;
      }
    });
  }

  void _logout() {
    // Simulación de cierre de sesión
    Navigator.of(context).pushReplacementNamed('/login');
  }

  // Muestra la pestaña flotante del carrito
  void _showCartSheet() {
    final mediaQuery = MediaQuery.of(context);
    final isLargeScreen =
        mediaQuery.size.width > 600; // Define una pantalla grande

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // Altura del modal adaptativa:
        // 85% de la altura de la pantalla en móvil/pantallas pequeñas.
        // 95% de la altura para aprovechar el espacio en pantallas grandes (tablets/desktop).
        final double modalHeight =
            mediaQuery.size.height * (isLargeScreen ? 0.95 : 0.85);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final double total = _cartItems.fold(
              0.0,
              (sum, item) => sum + (item.instrumento.precio * item.cantidad),
            );

            return Container(
              height: modalHeight, // Aplicamos la altura adaptativa
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: CartSheet(
                cartItems: _cartItems,
                total: total,
                onUpdateQuantity: (item, quantity) {
                  // Actualiza el estado del MainCatalogScreen y del modal
                  setState(() {
                    _updateCartQuantity(item, quantity);
                  });
                  setModalState(() {}); // Actualiza el estado del modal
                },
              ),
            );
          },
        );
      },
    );
  }

  double get _totalPrice => _cartItems.fold(
    0.0,
    (sum, item) => sum + (item.instrumento.precio * item.cantidad),
  );
  int get _totalItems => _cartItems.fold(0, (sum, item) => sum + item.cantidad);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- Lógica de Responsive con MediaQuery (Mantenida) ---
    final screenWidth = MediaQuery.of(context).size.width;
    // Define el ancho mínimo deseado para cada tarjeta del producto.
    const double minItemWidth = 200;
    // Calcula el número de columnas: divide el ancho de la pantalla por el ancho mínimo.
    // clamp(2, 5) asegura un mínimo de 2 columnas y un máximo de 5.
    final int crossAxisCount = (screenWidth / minItemWidth).floor().clamp(2, 5);
    // ------------------------------------------

    return DefaultTabController(
      length: categorias.length,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Catálogo Musical',
            style: theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          actions: [
            // Botón de perfil/Cerrar Sesión
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: theme.colorScheme.secondary,
              ),
              onPressed: _logout,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: categorias.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        body: Stack(
          children: [
            // Contenido principal (TabBarView)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 80.0,
              ), // Espacio para la barra de resumen
              child: TabBarView(
                children: categorias.map((categoria) {
                  final instrumentos = categoria == 'Todos'
                      ? todosInstrumentos
                      : todosInstrumentos
                            .where((i) => i.categoria == categoria)
                            .toList();

                  if (instrumentos.isEmpty) {
                    return Center(
                      child: Text(
                        'No hay instrumentos en esta categoría.',
                        style: theme.textTheme.titleMedium,
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          crossAxisCount, // Usamos la cuenta calculada
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio:
                          0.75, // Ajuste para que se parezca al diseño
                    ),
                    itemCount: instrumentos.length,
                    itemBuilder: (context, index) {
                      return InstrumentoTile(
                        instrumento: instrumentos[index],
                        onAddToCart: _addToCart,
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Barra de Resumen del Carrito (Parte inferior)
            Align(
              alignment: Alignment.bottomCenter,
              child: CartSummaryBar(
                totalItems: _totalItems,
                totalPrice: _totalPrice,
              ),
            ),
          ],
        ),
        // Botón de Carrito (Floating Action Button) - siempre visible
        floatingActionButton: FloatingActionButton(
          onPressed: _showCartSheet,
          backgroundColor: theme.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Badge(
            label: Text(_totalItems.toString()),
            backgroundColor: theme.colorScheme.primary,
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
