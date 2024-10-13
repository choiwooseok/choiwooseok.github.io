import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> numbers = List<int>.generate(45, (index) => index + 1);
  List<List<int>> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar(), body: body());
  }

  AppBar appbar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        children: [
          const SizedBox(width: 8),
          Text('Lottery', style: GoogleFonts.acme(color: Colors.white)),
          const SizedBox(width: 8),
          Image.network(
              'https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fchoiwooseok.github.io&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false'),
        ],
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
          tooltip: 'Shuffle History',
          icon: const Icon(Icons.shuffle, color: Colors.white),
          onPressed: () {
            history.shuffle(Random.secure());
            setState(() {});
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Clear History',
          icon:
              const Icon(Icons.cleaning_services_outlined, color: Colors.white),
          onPressed: () {
            _clearHistory();
            setState(() {});
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Generate Numbers',
          icon: const Icon(Icons.add_box_outlined, color: Colors.white),
          onPressed: () {
            numbers.shuffle(Random.secure());
            var selectedNumbers = numbers.sublist(0, 6);
            selectedNumbers.sort();
            history.add(selectedNumbers);
            setState(() {});
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Container body() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      item(index, context),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center item(int index, BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _balls(index),
          const SizedBox(width: 8),
          _remove(index),
        ],
      ),
    );
  }

  void _clearHistory() {
    numbers = List<int>.generate(45, (index) => index + 1);
    history.clear();
  }

  IconButton _remove(int index) {
    return IconButton(
      tooltip: 'Remove History',
      icon: const Icon(Icons.delete, color: Colors.white),
      padding: const EdgeInsets.all(0),
      onPressed: () {
        history.removeAt(index);
        setState(() {});
      },
    );
  }

  GestureDetector _balls(int index) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: history[index].join(', ')));
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Copied to Clipboard',
                  maxLines: 1,
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 12),
                ),
              ),
              duration: const Duration(seconds: 1),
              showCloseIcon: true,
            ),
          );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 6; i++) ...[
                  _ball(history[index][i]),
                  const SizedBox(width: 4),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar _ball(int value) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: _getColor(value),
      child: Text(
        '$value',
        style: GoogleFonts.acme(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColor(int val) {
    switch (val ~/ 10) {
      case 0:
        return Colors.yellow.shade800;
      case 1:
        return Colors.blue.shade600;
      case 2:
        return Colors.red.shade600;
      case 3:
        return Colors.cyan.shade600;
      case 4:
      default:
        return Colors.green.shade600;
    }
  }
}
