import 'package:flutter/material.dart';
import 'package:restaurantui/src/Components/listViewAnim.dart';

import '../../constants.dart';

class MyNotifications extends StatefulWidget {
  @override
  _MyNotificationsState createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation profileOpacity, listOpacity;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.forward();
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
        title: Text('Notifications'),
      ),
      body: Center(
          child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return SlideAnimation(
              itemCount: images.length,
              position: index,
              animationController: _animationController,
              slideDirection: SlideDirection.fromBottom,
              child: Dismissible(
                key: Key('1'),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print("Add to favorite");
                  } else {
                    print('Remove item');
                  }
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Confirmation"),
                        content: const Text(
                            "Are you sure you want to delete this item?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
                background: Container(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        Text(
                          'Add to favorites',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          padding: const EdgeInsets.only(top: 12.0, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text(subTitle[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'RalewayBold',
                                      color: index == 0
                                          ? Colors.red
                                          : index == 1
                                              ? Colors.green
                                              : Colors.amber,
                                      fontSize: size.width < 414
                                          ? 18
                                          : size.width > 500
                                              ? 25
                                              : 20)),
                              SizedBox(height: size.height * 0.005),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}

List id = ["t1", "t2", "t3", "t4"];
List images = [
  "assets/images/pizza.jpg",
  "assets/images/healtysalad.jpg",
  "assets/images/spaghetti.jpg",
  "assets/images/beefSalad.jpg",
];
List title = ["Mixed Pizza", "Healty Salad", "Spaghetti", "Beef Salad"];
List subTitle = [
  "%20 Discount",
  "Limited Edition",
  "Free Delivery",
  "Limited Edition",
];
