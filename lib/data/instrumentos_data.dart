import '../models/instrumento.dart';

final List<Instrumento> todosInstrumentos = [
  Instrumento(
    nombre: 'Guitarra Acústica Clásica',
    fabricante: 'Yamaha',
    precio: 299.99,
    imagenUrl: 'https://placehold.co/100x100/A0C4FF/ffffff?text=Guitarra',
    detalles:
        'Ideal para principiantes. Tapa de pícea maciza que proporciona un tono rico y vibrante.',
    categoria: 'Cuerdas',
  ),
  Instrumento(
    nombre: 'Batería Acústica Fusion',
    fabricante: 'Tama',
    precio: 750.00,
    imagenUrl: 'https://placehold.co/100x100/BDB2FF/ffffff?text=Bateria',
    detalles:
        'Configuración de 5 piezas con herrajes de doble brazo. Sonido potente y articulado.',
    categoria: 'Percusión',
  ),
  Instrumento(
    nombre: 'Teclado Digital P-45',
    fabricante: 'Yamaha',
    precio: 450.50,
    imagenUrl: 'https://placehold.co/100x100/FFC6FF/ffffff?text=Teclado',
    detalles:
        '88 teclas contrapesadas con acción Graded Hammer Standard (GHS) para una sensación de piano auténtica.',
    categoria: 'Teclados',
  ),
  Instrumento(
    nombre: 'Saxofón Alto Estándar',
    fabricante: 'Selmer',
    precio: 1200.00,
    imagenUrl: 'https://placehold.co/100x100/FDFFB6/ffffff?text=Saxofon',
    detalles:
        'Acabado en laca dorada. Tono cálido y centrado, excelente para estudiantes intermedios.',
    categoria: 'Viento',
  ),
  Instrumento(
    nombre: 'Ukelele Soprano',
    fabricante: 'Kala',
    precio: 89.99,
    imagenUrl: 'https://placehold.co/100x100/CAFFBF/ffffff?text=Ukelele',
    detalles:
        'Cuerpo de caoba. Sonido brillante y clásico. Incluye funda de transporte.',
    categoria: 'Cuerdas',
  ),
  Instrumento(
    nombre: 'Platillos Hi-Hat 14"',
    fabricante: 'Zildjian',
    precio: 180.00,
    imagenUrl: 'https://placehold.co/100x100/9BF6FF/ffffff?text=Platillos',
    detalles:
        'Serie A Custom. Brillantes y limpios, perfectos para cualquier género.',
    categoria: 'Percusión',
  ),
];

final List<String> categorias = [
  'Todos',
  'Cuerdas',
  'Teclados',
  'Percusión',
  'Viento',
];
