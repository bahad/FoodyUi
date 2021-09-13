import 'package:flutter/material.dart';
import 'package:restaurantui/src/Components/customButton.dart';
import 'package:restaurantui/src/Components/listViewAnim.dart';

import '../../constants.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('My Orders'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return SlideAnimation(
                        itemCount: images.length,
                        position: index,
                        animationController: _animationController,
                        slideDirection: SlideDirection.fromBottom,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(6),
                          color: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.303,
                                  height: size.height * 0.152,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(images[index]))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(title[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'RalewayBold',
                                              fontSize: size.width < 414
                                                  ? 20
                                                  : size.width > 500
                                                      ? 27
                                                      : 22)),
                                      SizedBox(height: size.height * 0.005),
                                      Text("£ " + price[index].toString(),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: size.width < 414
                                                  ? 18
                                                  : size.width > 500
                                                      ? 25
                                                      : 20)),
                                      SizedBox(height: size.height * 0.005),
                                      Transform.scale(
                                        scale: size.width < 500 ? 1.0 : 1.2,
                                        child: Chip(
                                            backgroundColor:
                                                status[index] == "Delivered"
                                                    ? Colors.greenAccent
                                                    : status[index] == "Pending"
                                                        ? Colors.amber
                                                        : Colors.lightBlue,
                                            label: Text(status[index])),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  topPadding: size.height * 0.02,
                  label: 'Okey',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                )
              ],
            )),
      ),
    );
  }
}

List images = [
  "assets/images/soup2.jpg",
  "assets/images/salad.jpg",
  "assets/images/hamburger.jpg",
  "assets/images/dessert.jpg",
  "assets/images/chicken.jpg"
];
List title = [
  "Lentil Soup",
  "Vegetarian Salad",
  "Hamburger",
  "Strawberry Pie",
  "Chicken"
];
List<int> price = [10, 5, 20, 24, 15];

List<String> status = [
  "Delivered",
  "Delivery",
  "Pending",
  "Pending",
  "Pending"
];
