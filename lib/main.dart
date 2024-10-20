// lib/main.dart

// Importing necessary packages
import 'package:fd_drag/icon_dragging_page.dart';
import 'package:flutter/material.dart'; // Importing Flutter's material design package for building UI

// Main function to start the Flutter application
void main() => runApp(
    const MyApp()); // Running the MyApp widget as the root of the application

// MyApp widget, which serves as the main application entry point
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor with an optional key parameter

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Draggable Icons', // Setting the title of the application
        home:
            IconDraggingPage(), // Setting the home widget to IconDragPage, which contains the draggable icons feature
      );
}
