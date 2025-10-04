import 'package:flutter/material.dart';
import 'recipe.dart';
import 'package:dontwastefood/ingredient_card.dart';

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
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 90, right: 20.0),
                  child: Row(
                    children: [
                      FittedBox(
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
                      Spacer(),
                      IconButton(
                          color: const Color(0xFFF9F6E7),
                          onPressed: () {
                            showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF9F6E7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, top: 30, right: 30),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ingredient Name',
                                            style: TextStyle(
                                              fontSize: getAdaptiveFontSize(20),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter a name',
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Quantity (grams)',
                                            style: TextStyle(
                                              fontSize: getAdaptiveFontSize(20),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter a value',
                                            ),
                                          ),
                                          SizedBox(height:10),
                                          Center(
                                            child: SizedBox(
                                              width:
                                                  200, // adjust this value as needed
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 7, 131, 9),
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: const Text('Save'),
                                                onPressed: () {
                                                  //TODO: ADD LOGIC TO ADD TO INGREDIENT LIST
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );

                            //TODO: Link to app_logic.dart
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                )
              ],
            ),
            // Add more recipe content below
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 800,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      10, //TODO: CHANGE THIS ACCORDING TO NUMBER OF AVAILABLE RECIPES
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            //TODO: CHANGE THIS TO ACTUAL FRIDGE ITEMS

                            return Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9F6E7),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, top: 30, right: 30),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name', // TODO: CHANGE THIS TO CURRENT RECIPE
                                        style: TextStyle(
                                          fontSize: getAdaptiveFontSize(28),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        child: ElevatedButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 200,
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Item ${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
