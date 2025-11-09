/// Modelo para un instrumento musical.
class Instrumento {
  final String nombre;
  final String fabricante;
  final double precio;
  final String imagenUrl;
  final String detalles;
  final String categoria;

  Instrumento({
    required this.nombre,
    required this.fabricante,
    required this.precio,
    required this.imagenUrl,
    required this.detalles,
    required this.categoria,
  });
}

/// Modelo para un artículo en el carrito.
class ArticuloCarrito {
  final Instrumento instrumento;
  int cantidad;

  ArticuloCarrito({required this.instrumento, this.cantidad = 1});
}
