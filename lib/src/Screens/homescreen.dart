import 'dart:convert';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'categoryDetail.dart';
import 'myCard.dart';

List categoryName = [
  "Breakfast",
  "Lunch",
  "Dinner",
  "Dessert",
  "Fastfood",
  "Fruits"
];
List categoryIcons = [
  "assets/icons/breakfast.png",
  "assets/icons/lunch.png",
  "assets/icons/dinner.png",
  "assets/icons/dessert.png",
  "assets/icons/fastfood.png",
  "assets/icons/fruits.png"
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController, _trendingAnimationController;
  Animation<double> progressValueAnimation,
      trendingAnimation,
      trendingOpacityAnimation;
  ScrollController _scrollController;
  Future dealFuture, trendingFuture, nearbyFuture;
  @override
  void initState() {
    dealFuture =
        DefaultAssetBundle.of(context).loadString('assets/data/dealData.json');
    trendingFuture = DefaultAssetBundle.of(context)
        .loadString('assets/data/trendingData.json');
    nearbyFuture = DefaultAssetBundle.of(context)
        .loadString('assets/data/nearbyData.json');
    _scrollController = ScrollController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    progressValueAnimation =
        Tween(begin: 0.0, end: 0.7).animate(animationController)
          ..addListener(() {
            setState(() {
              // the state that has changed here is the animation object’s value
            });
          });
    _trendingAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    trendingAnimation = Tween(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _trendingAnimationController,
        curve: Interval(
          0.830,
          1.000,
          curve: Curves.ease,
        ),
      ),
    );
    trendingOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _trendingAnimationController,
        curve: Interval(
          0.830,
          1.000,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    animationController.forward();
    _trendingAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _scrollController.dispose();
    _trendingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final titleTextStyle = size.width < 414
        ? normalTitleStyle
        : size.width > 500
            ? xlargeTitleStyle
            : largeTitleStyle;
    final textTextStyle = size.width < 414
        ? smallTitleStyle
        : size.width > 500
            ? largeTitleStyle
            : normalTitleStyle;
    return Scaffold(
        body: NestedScrollView(
      key: UniqueKey(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              snap: true,
              backgroundColor: primaryColor,
              expandedHeight: size.height * 0.153, //120,
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello Ariana', style: normalTitleStyle),
                  const SizedBox(),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.shopping_cart_outlined,
                              size: size.width < 414
                                  ? 26
                                  : size.width > 500
                                      ? 34
                                      : 28),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCard()));
                          }),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/myprofile'),
                        child: CircleAvatar(
                          radius: size.width < 414
                              ? 20
                              : size.width > 500
                                  ? 27
                                  : 22,
                          backgroundImage:
                              AssetImage('assets/icons/avatar.jpg'),
                        ),
                      )
                    ],
                  )
                ],
              ),
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              isDense: true,
                              hintText: 'Search ...',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ));
              })),
        ];
      },
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('Deal of the Day', style: titleTextStyle),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: dealFuture,
                  builder: (context, snapshot) {
                    var mydata = json.decode(snapshot.data.toString());
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      height: size.height * 0.182,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mydata.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.all(6),
                            color: Colors.grey[50],
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.333,
                                  height: size.height * 0.182,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              mydata[index]['image']))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(mydata[index]['title'],
                                          style: size.width < 414
                                              ? smallTitleStyle
                                              : size.width > 500
                                                  ? largeTitleStyle
                                                  : normalTitleStyle),
                                      Row(
                                        children: [
                                          Text(
                                            "£" +
                                                mydata[index]['price']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: size.width < 414
                                                    ? 20
                                                    : size.width > 500
                                                        ? 25
                                                        : 22),
                                          ),
                                          const SizedBox(width: 7),
                                          Text(
                                            "£" +
                                                mydata[index]['oldPrice']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.width < 414
                                                    ? 20
                                                    : size.width > 500
                                                        ? 25
                                                        : 22,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: size.height * 0.012, //10,
                                            width: size.width * 0.222,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: LinearProgressIndicator(
                                                backgroundColor: Colors.grey,
                                                value: progressValueAnimation
                                                    .value,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.blueAccent)),
                                          ),
                                          const SizedBox(width: 7),
                                          Text(mydata[index]['dealLeft'],
                                              style: size.width < 414
                                                  ? verySmallTitleStyle
                                                  : size.width > 500
                                                      ? largeTitleStyle
                                                      : smallTitleStyle),
                                        ],
                                      ),
                                      index == 0
                                          ? Row(
                                              children: [
                                                Text(
                                                  'Best Seller of the week',
                                                  style: TextStyle(
                                                      fontSize: size.width < 500
                                                          ? 14
                                                          : 20),
                                                ),
                                                const SizedBox(width: 4),
                                                Image.asset(
                                                    'assets/icons/bestSeller.png',
                                                    height: size.width < 500
                                                        ? 20
                                                        : 28)
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
              const SizedBox(height: 15),
              Text('Choose by Category', style: titleTextStyle),
              const SizedBox(height: 7),
              Container(
                height: size.height * 0.140,
                child: Transform(
                  transform: Matrix4.translationValues(
                    trendingAnimation.value,
                    0.0,
                    0.0,
                  ),
                  child: Opacity(
                    opacity: trendingOpacityAnimation.value,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryName.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CategoryDetail(
                                            categoryName: categoryName[index],
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(categoryIcons[index],
                                          height: size.height * 0.055)),
                                  const SizedBox(height: 7),
                                  Text(categoryName[index],
                                      style: textTextStyle)
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Text('Trending This Week', style: titleTextStyle),
              const SizedBox(height: 10),
              Container(
                height: size.height * 0.300,
                child: Transform(
                  transform: Matrix4.translationValues(
                    trendingAnimation.value,
                    0.0,
                    0.0,
                  ),
                  child: Opacity(
                    opacity: trendingOpacityAnimation.value,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingTime.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.all(6),
                                color: Colors.grey[50],
                                child: Container(
                                  width: size.width * 0.333,
                                  height: size.height * 0.182,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              trendingImage[index]))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(trendingTitle[index],
                                      style: size.width < 414
                                          ? smallTitleStyle
                                          : size.width > 500
                                              ? largeTitleStyle
                                              : normalTitleStyle),
                                  Text(
                                    trendingSubTitle[index],
                                    style: size.width < 414
                                        ? verySmallTextStyle
                                        : size.width > 500
                                            ? normalTextStyle
                                            : smallTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(trendingTime[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width < 414
                                                  ? 15
                                                  : size.width > 500
                                                      ? 20
                                                      : 17)),
                                      SizedBox(width: 20),
                                      Text(
                                        "£" +
                                            " " +
                                            trendingPrice[index].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: size.width < 414
                                                ? 15
                                                : size.width > 500
                                                    ? 20
                                                    : 17),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ),
              Text('Nearby', style: titleTextStyle),
              const SizedBox(height: 10),
              FutureBuilder(
                future: nearbyFuture,
                builder: (context, snapshot) {
                  var mydata = json.decode(snapshot.data.toString());
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    height: size.height * 0.300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: mydata.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.all(6),
                                color: Colors.grey[50],
                                child: Container(
                                  width: size.width * 0.333,
                                  height: size.height * 0.182,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              mydata[index]['image']))),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(mydata[index]["title"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: size.width < 414
                                          ? smallTitleStyle
                                          : size.width > 500
                                              ? largeTitleStyle
                                              : normalTitleStyle),
                                  Text(
                                    mydata[index]["subTitle"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: size.width < 414
                                        ? verySmallTextStyle
                                        : size.width > 500
                                            ? normalTextStyle
                                            : smallTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(mydata[index]["time"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width < 414
                                                  ? 15
                                                  : size.width > 500
                                                      ? 20
                                                      : 17)),
                                      const SizedBox(width: 20),
                                      Text(
                                        "£" +
                                            " " +
                                            mydata[index]["price"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: size.width < 414
                                                ? 15
                                                : size.width > 500
                                                    ? 20
                                                    : 17),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        )),
      ),
    ));
  }
}

List trendingID = ["t1", "t2", "t3"];
List trendingImage = [
  "assets/images/pizza.jpg",
  "assets/images/healtysalad.jpg",
  "assets/images/spaghetti.jpg",
];
List trendingTitle = [
  "Mixed Pizza",
  "Healty Salad",
  "Spaghetti",
];
List trendingSubTitle = [
  "Olives, sausage",
  "Beans, eggs",
  "Tomato sauce",
];
List trendingTime = ["30 - 40 min", "5 - 10 min", "10 - 15 min"];
List trendingPrice = [30, 15, 10];
