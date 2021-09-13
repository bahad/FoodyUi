import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantui/src/Components/customButton.dart';
import 'package:restaurantui/src/Components/listViewAnim.dart';
import 'package:restaurantui/src/Screens/checkout.dart';

import '../../constants.dart';

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final titleTextStyle = size.width < 411
        ? smallTitleStyle
        : size.width > 500
            ? xlargeTitleStyle
            : normalTitleStyle;
    final textTextStyle = size.width < 411
        ? smallTextNormalStyle
        : size.width > 500
            ? xlargeTextNormalStyle
            : normalTextNormalStyle;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Card'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: RawScrollbar(
                  thickness: 4.0,
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView(
                      padding: const EdgeInsets.all(6),
                      controller: _scrollController,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          images.length,
                          (index) => SlideAnimation(
                                itemCount: images.length,
                                position: index,
                                animationController: _animationController,
                                slideDirection: SlideDirection.fromBottom,
                                child: CardWidget(
                                  index: index,
                                ),
                              ))),
                ),
              ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal: ',
                      style: titleTextStyle,
                    ),
                    const SizedBox(),
                    Text('£ 120', style: textTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax & Fees: ',
                      style: titleTextStyle,
                    ),
                    const SizedBox(),
                    Text('£ 1', style: textTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery',
                      style: titleTextStyle,
                    ),
                    const SizedBox(),
                    Text('0', style: textTextStyle),
                  ],
                ),
              ),

              CustomButton(
                topPadding: 20,
                label: 'Submit',
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => CheckOut()));
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final int index;

  const CardWidget({this.index});
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final titleTextStyle = size.width < 411
        ? smallTitleStyle
        : size.width > 500
            ? xlargeTitleStyle
            : normalTitleStyle;
    final textTextStyle = size.width < 411
        ? verySmallTextNormalStyle
        : size.width > 500
            ? xlargeTextNormalStyle
            : normalTextNormalStyle;
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.150,
            width: size.width * 0.330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(images[widget.index]))),
          ),
          Flexible(child: const FractionallySizedBox(widthFactor: 0.1)),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title[widget.index], style: titleTextStyle),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_itemCount > 0) {
                            _itemCount--;
                          }
                        });
                      },
                      child: Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                            child: Text(
                          '-',
                          style: TextStyle(fontSize: 28),
                        )),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(_itemCount.toString(), style: textTextStyle),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => setState(() => _itemCount++),
                      child: Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                            child: Text(
                          '+',
                          style: TextStyle(fontSize: 28),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "£ " + (price[widget.index] * _itemCount).toStringAsFixed(2),
                  style: titleTextStyle,
                ),
              ],
            ),
          ),
        ],
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
