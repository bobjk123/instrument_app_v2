import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

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

    // Si no hay controller, caemos a comportamiento estático.
    final controller = _controller;
    if (controller == null || controller.animation == null) {
      final borderColor = _selected ? Colors.black : Colors.grey.shade200;
      final borderWidth = _selected ? 2.0 : 1.0;
      final iconSize = _selected ? 20.0 : 18.0;
      final iconColor = _selected ? Colors.black : theme.colorScheme.primary;
      return Tab(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              // Movemos los iconos un poco más hacia arriba por defecto y
              // ligeramente más cuando están seleccionados para aumentar la separación
              // respecto a la etiqueta.
              offset: Offset(0, _selected ? -12 : -8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(6),
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
                child: Icon(icon, size: iconSize, color: iconColor),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                color: _selected ? Colors.black : Colors.grey.shade600,
                fontWeight: _selected ? FontWeight.bold : FontWeight.normal,
              ),
              child: SizedBox(
                height: 8,
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

    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        // Progreso de selección: 1.0 cuando la pestaña está completamente seleccionada,
        // 0.0 cuando está completamente deseleccionada. Basado en la distancia entre
        // el valor de la animación y el índice de la pestaña.
        final double distance = (controller.animation!.value - widget.index)
            .abs();
        final double t = (1.0 - distance).clamp(0.0, 1.0);

        // Interpolaciones para varios parámetros visuales.
        final double iconSize = lerpDouble(18, 20, t)!;
        final double borderWidth = lerpDouble(1, 2, t)!;
        final Color borderColor = Color.lerp(
          Colors.grey.shade200,
          Colors.black,
          t,
        )!;
        final Color iconColor = Color.lerp(
          theme.colorScheme.primary,
          Colors.black,
          t,
        )!;
        final double shadowAlpha = lerpDouble(0.0, 0.08, t)!;
        // Interpolamos entre -8 (base) y -12 (seleccionada) para la animación.
        final double translateY = lerpDouble(-8, -12, t)!;

        return Tab(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(0, translateY),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: borderWidth),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                    boxShadow: t > 0
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: shadowAlpha,
                              ),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(icon, size: iconSize, color: iconColor),
                ),
              ),
              const SizedBox(height: 2),
              // Bajamos visualmente la etiqueta para separarla del icono.
              Transform.translate(
                offset: const Offset(0, 6),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    fontSize: 12,
                    color: t > 0.5 ? Colors.black : Colors.grey.shade600,
                    fontWeight: t > 0.5 ? FontWeight.bold : FontWeight.normal,
                  ),
                  child: SizedBox(
                    height: 8,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
