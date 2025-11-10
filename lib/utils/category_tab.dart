import 'package:flutter/material.dart';

// Widget personalizado para cada pestaña de categoría.
class CategoryTab extends StatefulWidget implements PreferredSizeWidget {
  final int index;
  final String label;

  const CategoryTab({required this.index, required this.label, super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class _CategoryTabState extends State<CategoryTab> {
  late final TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = DefaultTabController.of(context);
    // Rebuild cuando cambie la pestaña
    _controller?.animation?.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _controller?.animation?.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() => setState(() {});

  IconData _iconForLabel(String label) {
    switch (label) {
      case 'Cuerdas':
        return Icons.queue_music; // cuerdas / playlist-like
      case 'Teclados':
        return Icons.keyboard; // teclado
      case 'Percusión':
        return Icons.audiotrack; // aproximación a percusión
      case 'Viento':
        return Icons.record_voice_over; // aproximación a instrumentos de viento
      case 'Todos':
      default:
        return Icons.music_note; // general
    }
  }

  bool get _selected {
    final controller = _controller;
    if (controller == null) return false;
    // controller.index puede no ser entero durante la animación,
    // usamos round() para determinar la pestaña activa
    return controller.index == widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = _iconForLabel(widget.label);

    final borderColor = _selected ? Colors.black : Colors.grey.shade200;
    final borderWidth = _selected ? 2.0 : 1.0;
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Elevamos ligeramente el icono para acercarlo más a la parte superior
          // de la pestaña y mejorar la separación visual con la etiqueta.
          Transform.translate(
            offset: const Offset(0, -8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              // disminuir padding para ahorrar espacio vertical
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
                boxShadow: _selected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: AnimatedScale(
                scale: _selected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  icon,
                  size: 20,
                  color: _selected ? Colors.black : theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          // Ajuste para evitar overflow vertical: FittedBox reducirá el tamaño
          // del texto cuando el espacio vertical sea limitado (p. ej. textScaleFactor grande).
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 12,
              color: _selected ? Colors.black : Colors.grey.shade600,
              fontWeight: _selected ? FontWeight.bold : FontWeight.normal,
            ),
            child: SizedBox(
              // altura máxima disponible para la etiqueta dentro de la pestaña
              height: 16,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
