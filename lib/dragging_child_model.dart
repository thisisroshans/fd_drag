import 'package:flutter/material.dart';

class DraggingChildModel {
  // The icon data associated with this draggable item
  final IconData iconData;

  // The current index of this item in the list
  final int index;

  // The index of the last item that was updated during dragging, if any
  final int? lastUpdatedIndex;

  // Callback that gets called when an item is dragged and accepted into a new position
  final ValueChanged<int> onAcceptWithDetailsCallback;

  // Callback that gets called when the animation for the draggable item ends
  final VoidCallback onAnimationEndCallback;

  // Constructor for the DraggingChildModel class
  DraggingChildModel({
    required this.iconData,
    required this.index,
    required this.lastUpdatedIndex,
    required this.onAcceptWithDetailsCallback,
    required this.onAnimationEndCallback,
  });
}
