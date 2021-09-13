import 'package:flutter/material.dart';
import 'package:restaurantui/constants.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation profileOpacity, listOpacity;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    profileOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.200,
          0.300,
          curve: Curves.easeIn,
        ),
      ),
    );
    listOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.300,
          0.500,
          curve: Curves.easeIn,
        ),
      ),
    );
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
        title: Text('My Profile'),
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          FadeTransition(
            opacity: profileOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/icons/avatar.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Veronicajsts@gmail.com',
                      style: TextStyle(
                          fontFamily: 'RalewayBold',
                          fontSize: size.width < 414
                              ? 19
                              : size.width > 500
                                  ? 26
                                  : 21),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Veronica',
                      style: TextStyle(
                          fontSize: size.width < 414
                              ? 17
                              : size.width > 500
                                  ? 24
                                  : 19),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          FadeTransition(
            opacity: listOpacity,
            child: Container(
                child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: iconData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(
                      iconData[index],
                      color: primaryColor,
                      size: size.width > 500 ? 32 : 24,
                    ),
                    title: Text(
                      title[index],
                      style: TextStyle(
                          fontFamily: 'RalewayMedium',
                          fontSize: size.width < 414
                              ? 17
                              : size.width > 500
                                  ? 24
                                  : 19),
                    ),
                    onTap: () => Navigator.pushNamed(context, pageName[index]),
                  ),
                );
              },
            )),
          ),
          const SizedBox(height: 0),
        ],
      )),
    );
  }
}

List iconData = [
  Icons.card_giftcard,
  Icons.notifications_active,
  Icons.favorite_outline,
  Icons.help_center
];
List title = ["My Orders", "Notifications", "Favorites", "Help Center"];
List pageName = ['/myorders', '/mynotifications', '', ''];
