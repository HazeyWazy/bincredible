import 'package:flutter/material.dart';
import '../../models/waste_item.dart';

class GameBin extends StatelessWidget {
  final BinType binType;
  final String label;
  final Color color;
  final IconData icon;
  final Function(BinType) onAccept;

  const GameBin({
    super.key,
    required this.binType,
    required this.label,
    required this.color,
    required this.icon,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<WasteItem>(
      builder: (context, candidateData, rejectedData) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 80,
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty ? color.withValues(alpha: 0.7) : color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
            Container(
              width: 70,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );
      },
      onWillAcceptWithDetails: (data) => true,
      onAcceptWithDetails: (data) {
        onAccept(binType);
      },
    );
  }
}
