import '../models/instrumento.dart';

// Generamos 8 elementos por categoría. Las imágenes representativas están
// en `lib/assets/` y se usan como `imagenUrl` con la ruta relativa (asset).
final List<Instrumento> todosInstrumentos = [
  // Cuerdas
  for (var i = 1; i <= 8; i++)
    Instrumento(
      nombre: 'Guitarra Modelo $i',
      fabricante: 'Yamaha',
      precio: 199.99 + i * 25,
      imagenUrl: 'lib/assets/cuerda.jpg',
      detalles:
          'Guitarra acústica de cuerpo $i con buen sonido y afinación estable.',
      categoria: 'Cuerdas',
    ),

  // Teclados
  for (var i = 1; i <= 8; i++)
    Instrumento(
      nombre: 'Teclado Serie $i',
      fabricante: 'Casio',
      precio: 299.0 + i * 30,
      imagenUrl: 'lib/assets/teclado.png',
      detalles:
          'Teclado digital con múltiples sonidos y sensibilidad al tacto.',
      categoria: 'Teclados',
    ),

  // Percusión
  for (var i = 1; i <= 8; i++)
    Instrumento(
      nombre: 'Set de Percusión $i',
      fabricante: 'Tama',
      precio: 499.0 + i * 40,
      imagenUrl: 'lib/assets/percusion.jpg',
      detalles:
          'Set de percusión completo, ideal para práctica y presentaciones.',
      categoria: 'Percusión',
    ),

  // Viento
  for (var i = 1; i <= 8; i++)
    Instrumento(
      nombre: 'Instrumento de Viento $i',
      fabricante: 'Selmer',
      precio: 699.0 + i * 50,
      imagenUrl: 'lib/assets/viento.jpg',
      detalles: 'Instrumento de viento con timbre cálido y buena entonación.',
      categoria: 'Viento',
    ),
];

final List<String> categorias = [
  'Todos',
  'Cuerdas',
  'Teclados',
  'Percusión',
  'Viento',
];
