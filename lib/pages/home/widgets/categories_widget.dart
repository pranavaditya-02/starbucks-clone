import 'package:flutter/material.dart';
import 'package:starbucks/model/category_nodel.dart'; // Corrected typo in the import statement
import 'package:starbucks/pages/home/bakery_page.dart';
import 'package:starbucks/pages/home/drinks_page.dart';
import 'package:starbucks/pages/home/hot_coffee_page.dart';
import 'package:starbucks/pages/home/hot_teas_page.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({Key? key});

  List<CategoryModel> categories = [
    CategoryModel(name: "HOT COFFEE", icon: "assets/images/coffee.png"),
    CategoryModel(name: "DRINKS", icon: "assets/images/drinks.png"),
    CategoryModel(name: "HOT TEAS", icon: "assets/images/tea.png"),
    CategoryModel(name: "BAKERY", icon: "assets/images/bakery.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          for (var i = 0; i < categories.length; i++)
            Positioned(
              top: categories.length / 2 > i
                  ? 110 - (i * 35)
                  : 110 - ((categories.length - 1 - i) * 35),
              left: (i * MediaQuery.of(context).size.width) / categories.length,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / categories.length,
                height: 90,
                child: GestureDetector(
                  // Wrap with GestureDetector for onTap
                  onTap: () {
                    if (categories[i].name == "HOT COFFEE") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotCoffeePage()),
                      );
                    }
                    if (categories[i].name == "DRINKS") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrinksPage()),
                      );
                    }
                    if (categories[i].name == "BAKERY") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BakeryPage()),
                      );
                    }
                    if (categories[i].name == "HOT TEAS") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotTeasPage()),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            categories[i].icon,
                            width: 40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        categories[i].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
