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
  List<int> numbers = [];
  List<List<int>> history = [];

  @override
  void initState() {
    super.initState();
    numbers = List<int>.generate(45, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: body(),
    );
  }

  AppBar appbar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Lottery Number Generator',
          style: GoogleFonts.acme(color: Colors.white)),
      actions: [
        IconButton(
          tooltip: 'Shuffle History',
          icon: const Icon(Icons.shuffle, color: Colors.white),
          onPressed: () {
            history.shuffle(Random.secure());
            setState(() {});
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Clear History',
          icon:
              const Icon(Icons.cleaning_services_outlined, color: Colors.white),
          onPressed: () {
            _clearHistory();
            setState(() {});
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Generate Numbers',
          icon: const Icon(Icons.generating_tokens, color: Colors.white),
          onPressed: () {
            numbers.shuffle(Random.secure());
            var selectedNumbers = numbers.sublist(0, 6);
            selectedNumbers.sort();
            history.add(selectedNumbers);
            setState(() {});
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Container body() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return item(index, context);
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _balls(history[index]),
            const SizedBox(width: 12),
            _remove(index),
            const SizedBox(width: 12),
            _copyToClipBoard(index, context)
          ],
        ),
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
      onPressed: () {
        history.removeAt(index);
        setState(() {});
      },
    );
  }

  IconButton _copyToClipBoard(int index, BuildContext context) {
    return IconButton(
      tooltip: 'Copy to Clipboard',
      icon: const Icon(Icons.copy_all, color: Colors.white),
      onPressed: () {
        Clipboard.setData(ClipboardData(
          text: history[index].join(', '),
        ));
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: MediaQuery.of(context).size.width * 0.75,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              backgroundColor: Colors.green,
              content: Text(
                'Copied to Clipboard',
                style: GoogleFonts.acme(color: Colors.white),
              ),
              duration: const Duration(seconds: 1),
              showCloseIcon: true,
            ),
          );
      },
    );
  }

  Container _balls(List<int> selected) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 6; i++) ...[
              _ball(selected[i]),
              const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }

  CircleAvatar _ball(int value) {
    return CircleAvatar(
      backgroundColor: _getColor(value),
      child: Text(
        '$value',
        style: GoogleFonts.acme(
          color: Colors.white,
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
