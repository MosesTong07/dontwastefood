import 'package:flutter/material.dart';
import 'recipe.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  int _currentIndex = 0;

  // Screens for the bottom navigation bar
  final List<Widget> _pages = const [
    RecipeScreenContent(),
    IngredientsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F6E7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // container color will show
          selectedItemColor: Color.fromARGB(255, 7, 131, 9),
          unselectedItemColor: const Color(0xFF747474),
          iconSize: 40,
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
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
class IngredientsScreenContent extends StatelessWidget {
  const IngredientsScreenContent({super.key});

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
                    color: Color.fromARGB(255, 10, 155, 71),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 90),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Fridge',
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
                'BLABLABLA',
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