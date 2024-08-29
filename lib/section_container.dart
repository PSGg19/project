import 'dart:async';
import 'package:flutter/material.dart';
import 'list_item.dart';
import 'main_screen.dart';
import 'model.dart';

class SectionContainer extends StatefulWidget {
  final String title;
  final List<Item> items;
  final bool isGridView;

  const SectionContainer({
    required this.title,
    required this.items,
    required this.isGridView,
    super.key,
  });

  @override
  _SectionContainerState createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  List<bool> _isVisible = [];

  @override
  void initState() {
    super.initState();
    _isVisible = List<bool>.filled(widget.items.length, false);
    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < widget.items.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) {
          setState(() {
            _isVisible[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: GridView.builder(
              key: ValueKey<bool>(true),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(
                          image: item.iconUrl,
                          itemName: item.name,
                          flag: false,
                        ),
                      ),
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isVisible[index] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: AnimatedScale(
                      scale: _isVisible[index] ? 1.0 : 0.8,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.06,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item.iconUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            secondChild: Column(
              key: ValueKey<bool>(false),
              children: widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(
                          image: item.iconUrl,
                          itemName: item.name,
                          flag: false,
                        ),
                      ),
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isVisible[index] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: AnimatedScale(
                      scale: _isVisible[index] ? 1.0 : 0.8,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Items(item: item),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            crossFadeState: widget.isGridView
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }
}
