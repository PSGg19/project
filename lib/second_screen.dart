import 'package:cred_app/api.dart';
import 'package:flutter/material.dart';
import 'list_item.dart';
import 'main_screen.dart';
import 'model.dart';
import 'section_container.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isGridView = false;
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(
          image: "helo",
          itemName: "23",
          flag: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey, // Set the color of the back arrow to grey
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'explore',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'CRED',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _navigateToHome,
                  child: Container(
                    width: 35,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: const Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: _toggleView,
                  child: Container(
                    width: 45,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          alignment: _isGridView
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          duration: Duration(milliseconds: 200),
                          child: Icon(
                            _isGridView ? Icons.grid_view : Icons.list,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final categories = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: categories.map((category) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SectionContainer(
                    key: ValueKey<bool>(_isGridView),
                    title: category.title,
                    items: category.items,
                    isGridView: _isGridView,
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
