import 'package:flutter/material.dart';

import 'dragging_child_model.dart';

class DraggingChildWidget extends StatelessWidget {
  // The model containing the data and behavior for this draggable item
  final DraggingChildModel model;

  // Indicates whether this widget is currently being dragged
  final bool isDragging;

  // Constructor for DraggingChildWidget, requiring a model and dragging state
  const DraggingChildWidget(
      {super.key, required this.model, required this.isDragging});

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      // Determines if this widget will accept a dragged item
      onWillAcceptWithDetails: (details) {
        // Accept if the dragged item index is not the same as this item's index
        return details.data != model.index;
      },
      // Called when an item is accepted into this target
      onAcceptWithDetails: (details) {
        // Invoke the callback defined in the model
        model.onAcceptWithDetailsCallback(details.data);
      },
      builder: (context, candidateData, rejectedData) {
        // Builds the visual representation of the draggable item
        return Container(
          width: 60, // Width of the container
          height: 60, // Height of the container
          margin: const EdgeInsets.all(8.0), // Margin around the container
          decoration: BoxDecoration(
            color: Colors.lightBlue, // Background color of the container
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Center(
            // Centers the icon within the container
            child: Icon(
              model.iconData, // The icon data from the model
              size: 30, // Size of the icon
              color: Colors.white, // Color of the icon
            ),
          ),
        );
      },
    );
  }
}

// Widget that represents a placeholder during dragging
class PlaceHolderWidget extends StatelessWidget {
  // Constructor for PlaceHolderWidget
  const PlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds a blank container to represent a placeholder
    return Container(
      width: 60, // Width of the placeholder
      height: 60, // Height of the placeholder
      margin: const EdgeInsets.all(8.0), // Margin around the placeholder
    );
  }
}

// Widget that represents an icon while it is being dragged
class DraggingWidget extends StatelessWidget {
  // Constructor for DraggingWidget requiring the icon data
  const DraggingWidget({
    super.key,
    required this.icon, // Icon data to be displayed
  });

  final IconData icon; // Icon data to be used in the widget

  @override
  Widget build(BuildContext context) {
    // Builds the visual representation of the dragging icon
    return Material(
      color: Colors.blueAccent, // Background color for the dragging widget
      borderRadius: BorderRadius.circular(10), // Rounded corners
      child: Container(
        width: 60, // Width of the container
        height: 60, // Height of the container
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Background color of the container
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Icon(
          icon, // Icon being dragged
          size: 30, // Size of the icon
          color: const Color.fromARGB(255, 1, 1, 1), // Color of the icon
        ),
      ),
    );
  }
}
