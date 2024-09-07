import 'package:flutter/material.dart';
import 'package:starbucks/pages/home/cart_page.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
        const Text(
          "Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderSummaryScreen()),
            );
          },
          child: Image.asset(
            "assets/images/basket.png",
            width: 50,
          ),
        ),
      ],
    );
  }
}
