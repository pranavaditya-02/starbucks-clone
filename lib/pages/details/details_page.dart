import 'package:flutter/material.dart';
import 'package:starbucks/model/product_model.dart';
import 'package:starbucks/model/size_model.dart';
import 'package:starbucks/pages/details/widgets/details_app_bar.dart';
import 'package:starbucks/pages/details/widgets/order_button.dart';
import 'package:starbucks/pages/details/widgets/product_size.dart';
import 'package:starbucks/widgets/fade_in_down.dart';
import 'package:starbucks/model/description.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<SizeModel> sizes = [
    SizeModel(name: "Tall", qty: "12 Fl Oz"),
    SizeModel(name: "Grande", qty: "16 Fl Oz"),
    SizeModel(name: "Venti", qty: "24 Fl Oz"),
    SizeModel(name: "Custom", qty: "__ Fl Oz"),
  ];

  int selectedSize = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailsAppBar(),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            top: 0,
                            child: Hero(
                              tag: widget.product.name,
                              child: Image.asset(
                                widget.product.image,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                      from: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${widget.product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Best Sale",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                      from: 50,
                      child: const Text(
                        "Size Options",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FadeInDown(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 500),
                      from: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < sizes.length; i++)
                              GestureDetector(
                                onTap: () => setState(() {
                                  selectedSize = i;
                                }),
                                child: ProductSize(
                                  isSelected: selectedSize == i,
                                  iconSize: 25 + (i * 5),
                                  sizes: sizes[i],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: FadeInDown(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 500),
                          from: 50,
                          child: SingleChildScrollView(
                            child: Text(
                              widget.product.name == "Vanilla Frappuccino"
                                  ? ProductDescriptions.vanillaFrappuccino
                                  : widget.product.name == "Caramel Frappuccino"
                                      ? ProductDescriptions.caramelFrappuccino
                                      : widget.product.name ==
                                              "Mocha Coconut Frappuccino"
                                          ? ProductDescriptions
                                              .mochaCoconutFrappuccino
                                          : widget.product.name ==
                                                  "Matcha Green Tea"
                                              ? ProductDescriptions
                                                  .matchaGreenTea
                                              : widget.product.name ==
                                                      "Caramelly Intense Frappuccino"
                                                  ? ProductDescriptions
                                                      .caramellyIntenseFrappuccino
                                                  : widget.product.name ==
                                                          "Milkshake"
                                                      ? ProductDescriptions
                                                          .milkshake
                                                      : widget.product.name ==
                                                              "Caffè Americano"
                                                          ? ProductDescriptions
                                                              .caffeAmericano
                                                          : widget.product
                                                                      .name ==
                                                                  "Caffè Latte"
                                                              ? ProductDescriptions
                                                                  .caffeLatte
                                                              : widget.product
                                                                          .name ==
                                                                      "Cappuccino"
                                                                  ? ProductDescriptions
                                                                      .cappuccino
                                                                  : widget.product
                                                                              .name ==
                                                                          "Espresso"
                                                                      ? ProductDescriptions
                                                                          .espresso
                                                                      : widget.product.name ==
                                                                              "Flat White"
                                                                          ? ProductDescriptions
                                                                              .flatWhite
                                                                          : widget.product.name == "Caramel Macchiato"
                                                                              ? ProductDescriptions.caramelMacchiato
                                                                              : widget.product.name == "Chamomile Blossom Tea"
                                                                                  ? ProductDescriptions.chamomileBlossomTea
                                                                                  : widget.product.name == "Emperor's Cloud and Mist Green Tea"
                                                                                      ? ProductDescriptions.emperorsCloudMistGreenTea
                                                                                      : widget.product.name == "Jade Citrus Mint Green Tea"
                                                                                          ? ProductDescriptions.jadeCitrusMintGreenTea
                                                                                          : widget.product.name == "Peach Tranquility Herbal Tea"
                                                                                              ? ProductDescriptions.peachTranquilityHerbalTea
                                                                                              : widget.product.name == "Royal English Breakfast Tea"
                                                                                                  ? ProductDescriptions.royalEnglishBreakfastTea
                                                                                                  : widget.product.name == "Youthberry White Tea"
                                                                                                      ? ProductDescriptions.youthberryWhiteTea
                                                                                                      : widget.product.name == "Iced Chocolate"
                                                                                                          ? ProductDescriptions.icedChocolate
                                                                                                          : widget.product.name == "Pink Drink"
                                                                                                              ? ProductDescriptions.pinkDrink
                                                                                                              : widget.product.name == "Caramel Apple Spice"
                                                                                                                  ? ProductDescriptions.caramelAppleSpice
                                                                                                                  : widget.product.name == "Frappuccino Blended Beverages"
                                                                                                                      ? ProductDescriptions.frappuccinoBlendedBeverages
                                                                                                                      : widget.product.name == "Smoothies"
                                                                                                                          ? ProductDescriptions.smoothies
                                                                                                                          : widget.product.name == "Refreshers"
                                                                                                                              ? ProductDescriptions.refreshers
                                                                                                                              : widget.product.name == "Croissant"
                                                                                                                                  ? ProductDescriptions.croissant
                                                                                                                                  : widget.product.name == "Blueberry Muffin"
                                                                                                                                      ? ProductDescriptions.blueberryMuffin
                                                                                                                                      : widget.product.name == "Cinnamon Roll"
                                                                                                                                          ? ProductDescriptions.cinnamonRoll
                                                                                                                                          : widget.product.name == "Chocolate Chip Cookie"
                                                                                                                                              ? ProductDescriptions.chocolateChipCookie
                                                                                                                                              : '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const OrderButton(),
        ],
      ),
    );
  }
}
