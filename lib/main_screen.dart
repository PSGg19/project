import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:neopop/neopop.dart'; // Import the Neopop package
import 'second_screen.dart'; // Import the screen with the list of items

class MainScreen extends StatelessWidget {
  final String image; // Image URL or asset name
  final String itemName; // Item name
  final bool flag; // Flag to determine default or custom values

  // Constructor with required parameters
  const MainScreen({
    super.key,
    required this.image,
    required this.itemName,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which image and texts to display
    final displayImage = flag ? 'assets/image1.png' : image;
    final displayItemName = flag ? 'CRED Mint' : itemName;
    final displayText1 = flag ? 'Grow your savings.' : '';
    final displayText2 = flag ? '3x faster' : '';

    // Calculate dynamic heights and paddings based on screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.0), // Padding from the left and right
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.4), // 30% from the top

            // Display the image directly without a box
            if (flag)
              SizedBox(
                width: screenWidth * 0.5, // Image width
                child: Image.asset(
                  'assets/image1.png',
                  fit: BoxFit.cover,
                ),
              )
            else
              Image.network(
                displayImage,
                width: screenWidth * 0.5, // Adjust width as needed
                height: screenWidth * 0.5, // Fixed height
                fit: BoxFit.cover, // Ensures the image covers the area
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Error loading image'));
                },
              ),

            const SizedBox(height: 16), // Spacing between image and text

            // Display item name and texts based on flag
            Text(
              displayItemName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4), // Spacing between texts
            Text(
              displayText1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4), // Spacing between texts
            Text(
              displayText2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            const Spacer(), // Push the button to the bottom

            // Padding for NeoPop Button
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 32.0), // Padding from the bottom
              child: SizedBox(
                width: double.infinity, // Cover almost the whole width
                child: NeoPopButton(
                  color: Colors.white, // Button color
                  bottomShadowColor:
                      Colors.white.withOpacity(0.4), // White shadow for bottom
                  rightShadowColor:
                      Colors.white.withOpacity(0.2), // White shadow for right
                  animationDuration:
                      const Duration(milliseconds: 200), // Animation duration
                  depth: 4.0, // Depth for 3D effect
                  onTapUp: () {
                    HapticFeedback.vibrate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondScreen(),
                      ),
                    );
                  },
                  border: Border.all(
                    color: Colors.white, // Button border color
                    width: 2.0, // Button border width
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Go to Category",
                          style: TextStyle(
                              color: Colors.black), // Button text color
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
