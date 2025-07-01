import 'package:flutter/material.dart';
import '../../models/waste_item.dart';

class DraggableWasteItem extends StatelessWidget {
  final WasteItem wasteItem;
  final Function(DraggableDetails)? onDragEnd;

  const DraggableWasteItem({
    super.key,
    required this.wasteItem,
    this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<WasteItem>(
      data: wasteItem,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconForWasteItem(wasteItem),
                size: 50,
                color: Colors.black87,
              ),
              const SizedBox(height: 8),
              Text(
                wasteItem.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.2,
        child: _buildWasteItemWidget(),
      ),
      onDragEnd: onDragEnd,
      child: _buildWasteItemWidget(),
    );
  }
  
  Widget _buildWasteItemWidget() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIconForWasteItem(wasteItem),
            size: 80,
            color: Colors.black87,
          ),
          const SizedBox(height: 12),
          Text(
            wasteItem.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getIconForWasteItem(WasteItem item) {
    // In a real app, you would use actual images from assets
    // This is a placeholder using icons based on the waste type
    switch (item.correctBin) {
      case BinType.recycling:
        return Icons.recycling;
      case BinType.compost:
        return Icons.eco;
      case BinType.eWaste:
        return Icons.devices;
      case BinType.landfill:
        return Icons.delete;
      }
  }
}
