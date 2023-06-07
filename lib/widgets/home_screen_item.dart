import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../data/colors.dart';

enum activeButton {
  Buy,
  Sell,
  None,
}

//TODO: Get this data from firebase
const double balance = 50000; //will be set once and for all
const double usedBalance = 0;
//so i have a say x amount with me
// i have say 5 stocks that i can buy
// i need to ensure that i'm not spending more than i have
// i have a const variable that shows my balance(will be fetched from firebase)
//
// write data to get storage and read from it

// i'll need to store quantity, price and name of the stock so that data persists

class CardForStock extends StatefulWidget {
  final String name;
  final double price;

  double quantity = 0;

  //test vars

  CardForStock(this.name, this.price, this.quantity, {super.key});

  @override
  State<CardForStock> createState() => _CardForStockState();
}

class _CardForStockState extends State<CardForStock> {
  activeButton _active = activeButton.None;
  final _inputValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputValueController.text = '0';
    final box = GetStorage();
    var data = box.read('name');
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 400,
      margin: const EdgeInsets.only(bottom: 15, top: 15),
      child: Card(
        // shape: ShapeBorder,
        color: CustomColors.cardBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: CustomColors.textColor,
                  ),
                ),
              ),

              //buttons
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: CustomColors.textColor),
                          ),
                        ),
                        foregroundColor: _active == activeButton.Buy
                            ? MaterialStateProperty.all(
                                CustomColors.cardBackground)
                            : MaterialStateProperty.all(CustomColors.textColor),
                        backgroundColor: _active == activeButton.Buy
                            ? MaterialStateProperty.all(CustomColors.textColor)
                            : MaterialStateProperty.all(
                                CustomColors.cardBackground),
                      ),
                      autofocus: true,
                      onPressed: () {
                        setState(() {
                          _active = activeButton.Buy;
                        });
                      },
                      child: const Text('Buy'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: CustomColors.textColor),
                          ),
                        ),
                        foregroundColor: _active == activeButton.Sell
                            ? MaterialStateProperty.all(
                                CustomColors.cardBackground)
                            : MaterialStateProperty.all(CustomColors.textColor),
                        backgroundColor: _active == activeButton.Sell
                            ? MaterialStateProperty.all(CustomColors.textColor)
                            : MaterialStateProperty.all(
                                CustomColors.cardBackground),
                      ),
                      autofocus: false,
                      onPressed: () {
                        setState(() {
                          _active = activeButton.Sell;
                        });
                      },
                      child: const Text('Sell'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        foregroundColor: _active == activeButton.None
                            ? MaterialStateProperty.all(const Color(0xFF24257D))
                            : MaterialStateProperty.all(Colors.white),
                        backgroundColor: _active == activeButton.None
                            ? MaterialStateProperty.all(Colors.white)
                            : MaterialStateProperty.all(
                                const Color(0xFF24257D)),
                      ),
                      autofocus: false,
                      onPressed: () {
                        setState(() {
                          _active = activeButton.None;
                        });
                      },
                      child: const Text('None'),
                    ),
                  ),
                ],
              ),

              // slider+textfield
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //textfield
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                    height: 70,
                    width: 90,
                    child: Center(
                      child: TextField(
                        decoration: const InputDecoration(
                          // hintText: widget.quantity == 0 ? 'Quantity' : null,
                          // hintStyle: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16,
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          // labelText: 'Quantity',
                          // hintText: widget.quantity == 0 ? null : widget.quantity.toStringAsFixed(0),
                          // hintStyle: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 16,
                          // ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _inputValueController,
                        style: const TextStyle(
                          color: CustomColors.textColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            widget.quantity = double.parse(value);
                          });
                        },
                        onSubmitted: (value) {
                          if (_inputValueController.text.isEmpty) {
                            setState(() {
                              widget.quantity = 0;
                            });
                            return;
                          }
                          setState(() {
                            widget.quantity =
                                double.parse(_inputValueController.text);
                          });
                        },
                      ),
                    ),
                  ),

                  //slider
                  Slider(
                    activeColor: CustomColors.textColor,
                    inactiveColor: CustomColors.textColor,
                    // thumbColor: Colors.white,
                    min: 0,
                    max: 1000,
                    divisions: 1000,
                    value: widget.quantity,
                    // value: 0,
                    // label: ' ',
                    label: (widget.quantity).toStringAsFixed(0),
                    onChanged: (value) {
                      setState(() {
                        widget.quantity = double.parse(value.toString());
                        _inputValueController.text = value.toString();
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (balance < widget.quantity * widget.price)
                      ? 'Insufficient balance'
                      : 'Funds to be deducted after buying: ${((widget.quantity) * (widget.price)).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: CustomColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
