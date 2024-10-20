part of 'imports.dart';

// Stateful widget that represents a draggable icon interface
class IconDraggingPage extends StatefulWidget {
  const IconDraggingPage({super.key});

  @override
  State<IconDraggingPage> createState() => _IconDraggingPageState();
}

// State class for IconDragPage, managing the draggable icons and animations
class _IconDraggingPageState extends State<IconDraggingPage>
    with SingleTickerProviderStateMixin {
  // List of icons to be displayed in the draggable interface
  List<IconData> icons = [
    Icons.star,
    Icons.rocket_launch,
    Icons.celebration,
    Icons.lightbulb,
    Icons.accessibility,
  ];

  // Index of the last updated icon, used to track which item is being dragged
  int? lastUpdatedIndex;

  // Animation controller to manage animation state
  late AnimationController _controller;

  // Animation that scales the icons during the dragging process
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 300 milliseconds
    // The vsync is provided by the current state to optimize performance
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define a scaling animation using Tween to interpolate values between 1.0 and 0.5
    // A CurveTween is applied to create a bounce effect during the animation
    _animation = Tween<double>(begin: 1.0, end: 0.5)
        .chain(
          CurveTween(curve: Curves.bounceInOut),
        )
        .animate(_controller);

    // Add a listener to reverse the animation back to its original scale
    // after it completes the forward animation (bouncing)
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(); // Scale back to 1.0 after bouncing
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free up resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Icons'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Generate a list of draggable icon widgets
          children: List.generate(icons.length, (index) {
            // Create the model for managing dragging behavior of each icon
            DraggingChildModel draggingChildModel =
                _generateChildBehaviour(index);
            return ScaleTransition(
              // Apply scaling animation to the icon being dragged
              scale: lastUpdatedIndex == index
                  ? _animation
                  : const AlwaysStoppedAnimation(1.0),
              child: Draggable<int>(
                // The index is used as the data to identify which icon is being dragged
                data: index,
                // Widget displayed while dragging the icon
                feedback: DraggingWidget(icon: icons[index]),
                // Placeholder widget displayed when the icon is being dragged
                childWhenDragging: const PlaceHolderWidget(),
                // The actual widget displayed in the list
                child: DraggingChildWidget(
                  model: draggingChildModel,
                  isDragging: lastUpdatedIndex == index,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Generate the DraggingChildModel which encapsulates the behavior and state
  // for a draggable child at the given index
  DraggingChildModel _generateChildBehaviour(int index) {
    final draggingChildModel = DraggingChildModel(
      iconData: icons[index],
      index: index,
      lastUpdatedIndex: lastUpdatedIndex,
      // Callback when a draggable icon is accepted into this position
      onAcceptWithDetailsCallback: (fromIndex) {
        setState(() {
          // Remove the icon from its previous position and insert it at the new position
          final draggedIcon = icons.removeAt(fromIndex);
          icons.insert(index, draggedIcon);
          // Update the lastUpdatedIndex to the current index
          lastUpdatedIndex = index;
        });
        // Start the bounce animation when the icon is dropped
        _controller.forward(from: 0.0);
      },
      // Callback when the animation ends, resetting the last updated index
      onAnimationEndCallback: () {
        if (lastUpdatedIndex == index) {
          setState(() {
            lastUpdatedIndex = null;
          });
        }
      },
    );
    return draggingChildModel;
  }
}
