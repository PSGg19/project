import 'package:cred_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cred_app/api.dart';
import 'model.dart';
import 'api.dart';

class Items extends StatelessWidget {
  final Item item;

  const Items({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              image: item.iconUrl, // Pass the image URL
              itemName: item.name, // Pass the item name
              flag: false, // Set flag to false for custom values
            ),
          ), // Update this if you have dynamic navigation
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0), // Padding between items
        child: Container(
          height: 100, // Height for each item
          color: Colors.black,
          child: Row(
            children: [
              // Container around the image
              Container(
                width: 80.0, // Size of the container
                height: 80.0, // Size of the container
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 0.06, // Border width
                  ),
                ),
                // Centered image with fixed size of 40x40
                child: Center(
                  child: Container(
                    width: 40.0, // Fixed width of the image
                    height: 40.0, // Fixed height of the image
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.iconUrl),
                        fit: BoxFit
                            .cover, // Ensures the image covers the square box
                      ),
                      borderRadius:
                          BorderRadius.circular(0), // Optional: rounded corners
                    ),
                  ),
                ),
              ),
              // Text description
              Expanded(
                child: Container(
                  color: Colors.black,
                  padding:
                      const EdgeInsets.all(8.0), // Padding inside the container
                  child: Align(
                    alignment:
                        Alignment.centerLeft, // Align content to the left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align text to the start (left)
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center content vertically
                      children: [
                        Text(item.name,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                            height: 4), // Spacing between name and description
                        Text(
                          item.description,
                          style: TextStyle(
                            color:
                                Colors.grey.withOpacity(0.5), // Adjust opacity
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
