import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantui/src/Components/customButton.dart';
import 'package:restaurantui/src/Components/loadinganimation.dart';
import 'package:restaurantui/src/Services/cardFormatter.dart';
import 'package:restaurantui/src/Services/input_formatters.dart';

import '../../constants.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> with TickerProviderStateMixin {
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _card = new PaymentCard();
  AnimationController _animationController;
  Animation adressOpacity, paymentOpacity;
  @override
  void initState() {
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    adressOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.100,
          0.200,
          curve: Curves.easeIn,
        ),
      ),
    );
    paymentOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.300,
          0.400,
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFF215f00),
      content: Text(
        value,
        style: TextStyle(color: Colors.white, fontFamily: '', fontSize: 18),
      ),
    ));
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Checkout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: titleTextStyle,
                    ),
                    const SizedBox(),
                    Text('£ 121', style: textTextStyle),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: adressOpacity,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Adress',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'RalewayBold',
                                fontSize: size.width < 414
                                    ? 18
                                    : size.height > 500
                                        ? 24
                                        : 20)),
                        const SizedBox(height: 5),
                        Text('3825 West Side Avenue Rochelle Park, NJ 0766',
                            style: TextStyle(
                                fontFamily: 'RalewayMedium',
                                fontSize: size.width < 414
                                    ? 16
                                    : size.height > 500
                                        ? 22
                                        : 18)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: paymentOpacity,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            Text('Payment Methods',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'RalewayBold',
                                    fontSize: size.width < 414
                                        ? 18
                                        : size.height > 500
                                            ? 25
                                            : 20)),
                            const SizedBox(height: 5),
                            TextFormField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'John Doe',
                                labelText: 'Name',
                              ),
                              onSaved: (String value) {
                                _card.name = value;
                              },
                              validator: (String value) =>
                                  value.isEmpty ? Strings.fieldReq : null,
                            ),
                            TextFormField(
                              controller: numberController,
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(19)
                              ],
                              decoration: InputDecoration(
                                hintText: '2584 3542 2024 3486',
                                labelText: 'Card Number',
                                suffixIcon:
                                    CardUtils.getCardIcon(_paymentCard.type),
                              ),
                              onSaved: (String value) {
                                print('onSaved = $value');
                                print(
                                    'Num controller has = ${numberController.text}');
                                _paymentCard.number =
                                    CardUtils.getCleanedNumber(value);
                              },
                              validator: CardUtils.validateCardNum,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(4),
                                      CardMonthInputFormatter()
                                    ],
                                    cursorColor: primaryColor,
                                    // keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'MM/YY',
                                      labelText: 'Expiry Date',
                                    ),
                                    validator: CardUtils.validateDate,
                                    onSaved: (value) {
                                      List<int> expiryDate =
                                          CardUtils.getExpiryDate(value);
                                      _paymentCard.month = expiryDate[0];
                                      _paymentCard.year = expiryDate[1];
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        new LengthLimitingTextInputFormatter(3),
                                      ],
                                      cursorColor: primaryColor,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: 'CVV',
                                          suffixIcon:
                                              Icon(Icons.credit_card_sharp)),
                                      validator: CardUtils.validateCVV,
                                      onSaved: (value) {
                                        _paymentCard.cvv = int.parse(value);
                                      },
                                    ))
                              ],
                            ),
                            CustomButton(
                              topPadding: size.height * 0.022,
                              label: 'Confirm',
                              onPressed: () {
                                _showInSnackBar("Success! ");
                                Future.delayed(
                                    Duration(milliseconds: 1000),
                                    () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoadingAnimation(
                                                  routeName: '/myorders',
                                                ))));
                              },
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
