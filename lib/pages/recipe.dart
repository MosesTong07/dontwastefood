import 'package:flutter/material.dart';
import 'ingredients.dart'; // make sure this file exists and exports IngredientsScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecipeScreen(),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

// Navigation bar logic
class _RecipeScreenState extends State<RecipeScreen> {
  int _currentIndex = 0;

  // Screens for the bottom navigation bar
  final List<Widget> _pages = const [
    RecipeScreenContent(),
    IngredientsScreenContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F6E7), 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // shadow color
              blurRadius: 10, // softness of the shadow
              spreadRadius: 2, // how much the shadow spreads
              offset: const Offset(0, -3), // shadow above the bar
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF9F6E7), // container color shows
          currentIndex: _currentIndex,
          iconSize: 32,
          selectedItemColor: _currentIndex == 0
              ? const Color.fromARGB(255, 255, 183, 39)
              : const Color(0xFF058240),
          unselectedItemColor: const Color(0xFF747474),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant,
                color: _currentIndex == 0
                    ? const Color.fromARGB(255, 255, 183, 39)
                    : const Color(0xFF747474),
              ),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket,
                color: _currentIndex == 1
                    ? const Color(0xFF058240)
                    : const Color(0xFF747474),
              ),
              label: 'Ingredients',
            ),
          ],
        ),
      ),
    );
  }
}

// Separate stateless widget for Recipe screen content
//TODO:
class RecipeScreenContent extends StatelessWidget {
  const RecipeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double headerHeight = size.height * 0.2;

    double getAdaptiveFontSize(double fontSize) {
      return fontSize * size.width / 400;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6E7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: headerHeight,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 183, 39),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 90),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Recipes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width > 500
                            ? getAdaptiveFontSize(24)
                            : getAdaptiveFontSize(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Add more recipe content below
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your recipe list goes here...',
                style: TextStyle(
                  fontSize: getAdaptiveFontSize(18),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
