import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _withComma(double amount) {
  var amounts = NumberFormat("##,##,###.00", "en_US");
  return (amounts.format(amount).toString());
}

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var netWorth = 145879.90;
    var current = 80789.87;
    var invested = 75789.90;
    var profLoss = current - invested;
    var positiveOrNegative = current - invested > 0 ? '+' : '-';
    var profLossPercentage = (current - invested) / invested * 100;
    return SizedBox(
      height: 220,
      width: 380,
      // margin: EdgeInsets.only(top: 20, left: 20),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff20312B),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopPart(netWorth: netWorth),
            MiddlePart(
                current: current,
                invested: invested,
                positiveOrNegative: positiveOrNegative,
                profLoss: profLoss,
                profLossPercentage: profLossPercentage),
            BottomPart(netWorth: netWorth, current: current),
          ],
        ),
      ),
    );
  }
}

class CommonColumn extends StatelessWidget {
  const CommonColumn({super.key, 
    required this.money,
    required this.text,
  });

  final double money;
  final String text;

  @override
  Widget build(BuildContext context) {
    var printableString = _withComma(money);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            '\u{20B9} $printableString',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TopPart extends StatelessWidget {
  const TopPart({
    super.key,
    required this.netWorth,
  });

  final double netWorth;

  @override
  Widget build(BuildContext context) {
    var printableString = _withComma(netWorth);
    return Column(
      children: [
        const Text(
          'Net Worth',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        Text(
          '\u{20B9} $printableString',
          // '\u{20B9} ${netWorth.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 32, color: Colors.white),
        ),
      ],
    );
  }
}

class MiddlePart extends StatelessWidget {
  const MiddlePart({
    super.key,
    required this.current,
    required this.invested,
    required this.positiveOrNegative,
    required this.profLoss,
    required this.profLossPercentage,
  });

  final double current;
  final double invested;
  final String positiveOrNegative;
  final double profLoss;
  final double profLossPercentage;

  @override
  Widget build(BuildContext context) {
    var printableString = _withComma(profLoss.abs());
    return Column(
      children: [
        const Divider(
          color: Colors.white,
          indent: 10,
          endIndent: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonColumn(text: 'Current', money: current),
            CommonColumn(text: 'Invested', money: invested),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'P&L',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$positiveOrNegative\u{20B9} $printableString',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      '$positiveOrNegative ${profLossPercentage.abs().toStringAsFixed(2)} %',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const Divider(
          color: Colors.white,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({
    super.key,
    required this.netWorth,
    required this.current,
  });

  final double netWorth;
  final double current;

  @override
  Widget build(BuildContext context) {
    var printableString = _withComma((netWorth - current));
    return Text(
      ' Funds \u{20B9}$printableString',
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}
