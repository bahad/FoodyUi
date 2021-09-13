import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantui/src/Screens/plateDetail.dart';

import '../../constants.dart';

class CategoryDetail extends StatefulWidget {
  final String categoryName;

  const CategoryDetail({Key key, this.categoryName});
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  Future categoryFuture;
  @override
  void initState() {
    categoryFuture = DefaultAssetBundle.of(context)
        .loadString('assets/data/categoryDetail.json');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          widget.categoryName,
          style: normalTitleStyle,
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart_outlined,
                        size: size.width < 411
                            ? 26
                            : size.width > 500
                                ? 34
                                : 28),
                    onPressed: () {}),
                const SizedBox(width: 6),
                CircleAvatar(
                  radius: size.width < 411
                      ? 20
                      : size.width > 500
                          ? 27
                          : 22,
                  backgroundImage: AssetImage('assets/icons/avatar.jpg'),
                )
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: categoryFuture,
            builder: (context, snapshot) {
              var mydata = json.decode(snapshot.data.toString());
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mydata.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16.0),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: size.width > 500 ? 3 : 2,
                              childAspectRatio: 8.0 / 9.1,
                              crossAxisSpacing: 6.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PlateDetails(
                                          detailData: mydata[index],
                                        )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 18.0 / 12.0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.all(6),
                                  color: Colors.grey[50],
                                  child: Hero(
                                    tag: mydata[index]['id'],
                                    child: Container(
                                      //width: size.width * 0.333,
                                      //height: size.height * 0.182,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  mydata[index]['image']))),
                                    ),
                                  ),
                                ),
                              ),
                              new Padding(
                                padding:
                                    EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mydata[index]['title'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: size.width < 411
                                          ? smallTitleStyle
                                          : size.width > 500
                                              ? largeTitleStyle
                                              : normalTitleStyle,
                                    ),
                                    Text(
                                      mydata[index]['subTitle'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: size.width < 411
                                          ? verySmallTextStyle
                                          : size.width > 500
                                              ? normalTextStyle
                                              : smallTextStyle,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "£" +
                                          " " +
                                          mydata[index]["price"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: size.width < 411
                                              ? 17
                                              : size.width > 500
                                                  ? 21
                                                  : 19),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
