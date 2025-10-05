import 'package:dontwastefood/database.dart';
import 'package:flutter/material.dart';
import 'ingredients.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // make sure this file exists and exports IngredientsScreen

final supabase = Supabase.instance.client;
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
              label: 'Fridge',
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
    double bottomHeight = size.height * 0.8;

    double getAdaptiveFontSize(double fontSize) {
      return fontSize * size.width / 400;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6E7),
      body: StreamBuilder(
        stream: Database().streamRecipes,
        builder: (content, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Text("No data");
          }
          return SingleChildScrollView(
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
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                        ),
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Available Recipes',
                          style: TextStyle(
                            fontSize: getAdaptiveFontSize(24),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              2, //TODO: CHANGE THIS ACCORDING TO NUMBER OF AVAILABLE RECIPES
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    //TODO: CHANGE THIS TO ACTUAL FRIDGE ITEMS
                                    final List<dynamic>
                                    fridgeItems = item['ingredients_raw_str']
                                        .substring(
                                          1,
                                          item['ingredients_raw_str'].length -
                                              1,
                                        )
                                        .split('","')
                                        .map(
                                          (e) => e.trim().replaceAll('"', ""),
                                        )
                                        .toList();
                                    final List<bool> checked =
                                        List<bool>.filled(
                                          fridgeItems.length,
                                          true,
                                        );

                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF9F6E7),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.8, // optional: more adaptive height
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0,
                                          top: 30,
                                          right: 30,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['name'], // TODO: CHANGE THIS TO CURRENT RECIPE
                                                style: TextStyle(
                                                  fontSize: getAdaptiveFontSize(
                                                    28,
                                                  ),
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Fridge Items',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemCount: fridgeItems.length,
                                                itemBuilder: (context, index) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (
                                                          context,
                                                          setModalState,
                                                        ) => ListTile(
                                                          visualDensity:
                                                              const VisualDensity(
                                                                vertical: -4,
                                                              ),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          dense: true,
                                                          leading: Checkbox(
                                                            value:
                                                                checked[index],
                                                            onChanged: (v) =>
                                                                setModalState(
                                                                  () =>
                                                                      checked[index] =
                                                                          v ??
                                                                          false,
                                                                ),
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          title: Text(
                                                            fridgeItems[index],
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                          ),
                                                        ),
                                                  );
                                                },
                                              ),
                                              const Text(
                                                'Steps',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                item['steps']
                                                    .substring(
                                                      1,
                                                      item['steps'].length - 1,
                                                    )
                                                    .replaceAll("'", "")
                                                    .replaceAll(",'", ""),
                                                // 'The FitnessGram™ Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly, but gets faster each minute after you hear this signal. [beep] A single lap should be completed each time you hear this sound. [ding] Remember to run in a straight line, and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark, get ready, start.',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
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
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey, // grey border color
                                    width: 1, // border thickness
                                  ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        item['name'],
                                        style: const TextStyle(
                                          color: Color(0xFF5D5454),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recipes with Incomplete Items',
                          style: TextStyle(
                            fontSize: getAdaptiveFontSize(24),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              7, //TODO: CHANGE THIS ACCORDING TO NUMBER OF AVAILABLE RECIPES
                          itemBuilder: (context, index) {
                            final item = data[index + 5];
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    //TODO: CHANGE THIS TO ACTUAL FRIDGE ITEMS
                                    final List<dynamic>
                                    fridgeItems = item['ingredients_raw_str']
                                        .substring(
                                          1,
                                          item['ingredients_raw_str'].length -
                                              1,
                                        )
                                        .split(',')
                                        .map(
                                          (e) => e.trim().replaceAll('"', ""),
                                        )
                                        .toList();
                                    final List<bool> checked =
                                        List<bool>.filled(
                                          fridgeItems.length,
                                          false,
                                        );
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF9F6E7),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0,
                                          top: 30,
                                          right: 30,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['name'], // TODO: CHANGE THIS TO CURRENT RECIPE
                                                style: TextStyle(
                                                  fontSize: getAdaptiveFontSize(
                                                    28,
                                                  ),
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Fridge Items',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemCount: fridgeItems.length,
                                                itemBuilder: (context, index) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (
                                                          context,
                                                          setModalState,
                                                        ) => ListTile(
                                                          visualDensity:
                                                              const VisualDensity(
                                                                vertical: -4,
                                                              ),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          dense: true,
                                                          leading: Checkbox(
                                                            value:
                                                                checked[index],
                                                            onChanged: (v) =>
                                                                setModalState(
                                                                  () =>
                                                                      checked[index] =
                                                                          v ??
                                                                          false,
                                                                ),
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          title: Text(
                                                            fridgeItems[index],
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                          ),
                                                        ),
                                                  );
                                                },
                                              ),
                                              const Text(
                                                'Steps',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                item['steps']
                                                    .substring(
                                                      1,
                                                      item['steps'].length - 1,
                                                    )
                                                    .replaceAll("'", "")
                                                    .replaceAll(",'", ""),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
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
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey, // grey border color
                                    width: 1, // border thickness
                                  ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        item['name'],
                                        style: const TextStyle(
                                          color: Color(0xFF5D5454),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
