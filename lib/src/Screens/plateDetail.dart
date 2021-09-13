import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantui/constants.dart';

class PlateDetails extends StatefulWidget {
  final detailData;

  const PlateDetails({Key key, this.detailData});
  @override
  _PlateDetailsState createState() => _PlateDetailsState();
}

class _PlateDetailsState extends State<PlateDetails>
    with TickerProviderStateMixin {
  var top = 0.0;
  Future reviewFuture;
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    reviewFuture = DefaultAssetBundle.of(context)
        .loadString('assets/data/reviewData.json');
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final titleTextStyle = size.width < 411
        ? normalTitleStyle
        : size.width > 500
            ? xlargeTitleStyle
            : largeTitleStyle;
    final textTextStyle = size.width < 411
        ? verySmallTextNormalStyle
        : size.width > 500
            ? xlargeTextNormalStyle
            : normalTextNormalStyle;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: primaryColor,
                expandedHeight: size.height / 3.4, //215
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: false,
                    title: AnimatedOpacity(
                        opacity: top <= size.height * 0.142 ? 1 : 0,
                        duration: Duration(seconds: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.detailData['title']),
                            const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                    background: AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      opacity: top >= size.height * 0.152 ? 1 : 0,
                      child: Hero(
                          tag: widget.detailData['id'],
                          child: FadeInImage(
                            placeholder: AssetImage('assets/images/pizza.jpg'),
                            image: AssetImage(widget.detailData['image']),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                })),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.detailData['title'],
                  style: titleTextStyle,
                ),
                const SizedBox(),
                Text(
                  "£" + " " + widget.detailData["price"].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: size.width < 411
                          ? 19
                          : size.width > 500
                              ? 26
                              : 21),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '3825 West Side Avenue Rochelle Park, New Jersey 0766',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTextStyle,
                  ),
                ),
                const SizedBox(),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amberAccent),
                    const SizedBox(width: 5),
                    Text(
                      '4.5',
                      style: TextStyle(
                          fontSize: size.width < 411
                              ? 16
                              : size.width > 500
                                  ? 22
                                  : 17),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.lock_clock,
                  color: primaryColor,
                  size: size.width < 411
                      ? 24
                      : size.width > 500
                          ? 32
                          : 27,
                ),
                const SizedBox(width: 7),
                Text(widget.detailData['time'] + " + Delivery Time",
                    style: textTextStyle),
              ],
            ),
            const SizedBox(height: 7),
            RichText(
              text: new TextSpan(
                text: 'Chef: ',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: size.width < 411
                        ? 17
                        : size.width > 500
                            ? 23
                            : 19.0,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Jessica Star',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'RalewayRegular',
                        fontSize: size.width < 411
                            ? 17
                            : size.width > 500
                                ? 23
                                : 19),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus euismod congue ullamcorper.',
                style: textTextStyle),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reviews', style: titleTextStyle),
                const SizedBox(),
                Text(
                  '15 View All',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: size.width < 411
                          ? 17
                          : size.width > 500
                              ? 23
                              : 19),
                )
              ],
            ),
            const SizedBox(height: 15),
            FutureBuilder(
              future: reviewFuture,
              builder: (context, snapshot) {
                var mydata = json.decode(snapshot.data.toString());
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return RawScrollbar(
                  controller: _scrollController,
                  thickness: 4.0,
                  isAlwaysShown: true,
                  child: Container(
                    //height: size.height * 0.300,
                    child: ListView.builder(
                        controller: _scrollController,
                        //physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: mydata.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  leading: CircleAvatar(
                                    radius: 27,
                                  ),
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mydata[index]['author'],
                                        style: TextStyle(
                                            fontSize: size.width < 411
                                                ? 16
                                                : size.width > 500
                                                    ? 22
                                                    : 17),
                                      ),
                                      const SizedBox(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amberAccent,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            mydata[index]['star'].toString(),
                                            style: TextStyle(
                                                fontSize: size.width < 411
                                                    ? 16
                                                    : size.width > 500
                                                        ? 22
                                                        : 17),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  subtitle: Text(
                                    mydata[index]['description'],
                                    style: TextStyle(
                                        fontSize: size.width < 411
                                            ? 14
                                            : size.width > 500
                                                ? 20
                                                : 15),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
