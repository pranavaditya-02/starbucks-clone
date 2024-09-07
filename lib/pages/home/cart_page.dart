import 'package:flutter/material.dart';
import 'package:starbucks/pages/home/order_page.dart'; // Import PaymentPage

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'imageUrl':
          'https://globalassets.starbucks.com/digitalassets/products/bev/SBX20220323_CaramelFrapp.jpg?impolicy=1by1_wide_topcrop_630',
      'title': 'Starbucks Caramel Frappuccino',
      'subtitle': 'Grande, Less Ice',
      'price': 55.0,
      'quantity': 1,
    },
    {
      'imageUrl':
          'https://131594431.cdn6.editmysite.com/uploads/1/3/1/5/131594431/s551771300750639090_p156_i1_w600.jpeg',
      'title': 'Double Chocolate Chip Frappuccino',
      'subtitle': 'Grande, Less Ice',
      'price': 60.0,
      'quantity': 1,
    },
    {
      'imageUrl':
          'https://i.pinimg.com/736x/f3/ec/47/f3ec47e064c8fdee6241fc826d14bb67.jpg',
      'title': 'Strawberry Cream Frappuccino',
      'subtitle': 'Grande, Less Sugar',
      'price': 56.0,
      'quantity': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double subTotal = cartItems.fold(
        0,
        (previousValue, item) =>
            previousValue + item['price'] * item['quantity']);
    double deliveryFee = 16.0;
    int rewardPoints = 25;
    double grandTotal = subTotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Orders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return orderItem(index);
                },
              ),
            ),
            SizedBox(height: 20),
            summaryRow('Sub Total', 'IDR ${subTotal.toStringAsFixed(3)}'),
            summaryRow('Delivery Fee', 'IDR ${deliveryFee.toStringAsFixed(3)}'),
            summaryRow('Reward Points', '+$rewardPoints'),
            Divider(),
            summaryRow('Grand Total', 'IDR ${grandTotal.toStringAsFixed(3)}',
                isTotal: true),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          subTotal: subTotal,
                          deliveryFee: deliveryFee,
                          rewardPoints: rewardPoints,
                          grandTotal: grandTotal,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Order Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              cartItems[index]['imageUrl'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItems[index]['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cartItems[index]['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'IDR ${cartItems[index]['price'].toStringAsFixed(3)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      cartItems.removeAt(index);
                    });
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          if (cartItems[index]['quantity'] > 1) {
                            cartItems[index]['quantity']--;
                          }
                        });
                      },
                    ),
                    Text(cartItems[index]['quantity'].toString(),
                        style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          cartItems[index]['quantity']++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
