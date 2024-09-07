import 'package:flutter/material.dart';
import 'package:starbucks/model/product_model.dart';
import 'package:starbucks/pages/details/details_page.dart';
import 'package:starbucks/pages/home/widgets/categories_widget.dart';
import 'package:starbucks/pages/home/widgets/home_app_bar.dart';
import 'package:starbucks/widgets/top_oval_clipper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BakeryPage extends StatefulWidget {
  const BakeryPage({Key? key}) : super(key: key);

  @override
  _BakeryPageState createState() => _BakeryPageState();
}

class _BakeryPageState extends State<BakeryPage>
    with SingleTickerProviderStateMixin {
  final PageController _textSlideController = PageController();
  final PageController _imageSlideController = PageController(
    viewportFraction: 0.52,
  );

  final List<ProductModel> products = [
    ProductModel(
      name: "Croissant",
      price: 2.50,
      image: "assets/images/products/croissant.png",
    ),
    ProductModel(
      name: "Blueberry Muffin",
      price: 3.00,
      image: "assets/images/products/blueberry_muffin.png",
    ),
    ProductModel(
      name: "Cinnamon Roll",
      price: 3.25,
      image: "assets/images/products/cinnamon_roll.png",
    ),
    ProductModel(
      name: "Chocolate Chip Cookie",
      price: 2.00,
      image: "assets/images/products/chocolate_chip_cookie.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      _imageSlideController.animateToPage(1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _imageSlideController.dispose();
    _textSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(), // Appbar Widget
            Padding(
              padding: const EdgeInsets.only(left: 35, bottom: 1, top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Text(
                  "Bakery",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ClipPath(
                clipper: TopOvalClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Stack(
                    children: [
                      CategoriesWidget(), // List of category
                      Positioned(
                        top: 130,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _imageSlideController,
                          builder: (context, child) {
                            return PageView.builder(
                              itemCount: products.length,
                              controller: _imageSlideController,
                              onPageChanged: (page) {
                                _textSlideController.animateToPage(page,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                              itemBuilder: (context, index) {
                                double value = 0.0;
                                if (_imageSlideController
                                    .position.haveDimensions) {
                                  value = index.toDouble() -
                                      (_imageSlideController.page ?? 0);
                                  value = (value * 0.7).clamp(-1, 1);
                                }
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 50 + (value.abs() * 200)),
                                    child: Transform.scale(
                                      scale: 1 - (value.abs() * 0.05),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                product: products[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width: 280,
                                          height: 280,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
                                                width: 180,
                                                height: 180,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF47A978),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                top: 0,
                                                child: Hero(
                                                  tag: products[index].name,
                                                  child: Image.asset(
                                                    products[index].image,
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 100,
                        right: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: PageView.builder(
                                itemCount: products.length,
                                controller: _textSlideController,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        products[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          height: 1.1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "\$${products[index % products.length].price.toStringAsFixed(2)}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: _imageSlideController,
                              count: products.length,
                              effect: ScrollingDotsEffect(
                                spacing: 15.0,
                                radius: 8.0,
                                fixedCenter: true,
                                dotWidth: 5.0,
                                dotHeight: 5.0,
                                activeDotScale: 3,
                                dotColor: Colors.grey[400]!,
                                activeDotColor: Colors.white,
                              ),
                            )
                          ],
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
    );
  }
}
