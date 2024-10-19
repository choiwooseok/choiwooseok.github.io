import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/page_appbar.dart';
import '../components/page_drawer.dart';

class JsonFormatter extends StatefulWidget {
  const JsonFormatter({super.key});

  @override
  State<JsonFormatter> createState() => _JsonFormatterState();
}

class _JsonFormatterState extends State<JsonFormatter> {
  String _json = '';
  String _formattedJson = '';
  int _tabSize = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const PageAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'JSON Formatter',
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildJsonInputField(context),
              const SizedBox(width: 12),
              _buildControlPanel(),
              const SizedBox(width: 12),
              _buildFormattedJsonDisplay(context),
            ],
          ),
        ],
      ),
      endDrawer: const PageDrawer(),
    );
  }

  Widget _buildJsonInputField(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        width: MediaQuery.of(context).size.width * 0.42,
        height: MediaQuery.of(context).size.height * 0.5,
        child: TextField(
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(hintText: 'input text'),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() => _json = value);
          },
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Column(
      children: [
        Row(
          children: [
            const Text('Tab Size: ', style: TextStyle(color: Colors.white)),
            DropdownButton<int>(
              value: _tabSize,
              items: List.generate(3, (index) {
                return DropdownMenuItem<int>(
                  value: index * 2,
                  child: Text(
                    '${index * 2}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
              onChanged: (value) {
                setState(() => _tabSize = value!);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _formattedJson = JsonEncoder.withIndent(' ' * _tabSize)
                  .convert(jsonDecode(_json));
            });
          },
          child: const Text('Beautify'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _formattedJson = const JsonEncoder().convert(jsonDecode(_json));
            });
          },
          child: const Text('Minimal'),
        ),
      ],
    );
  }

  Widget _buildFormattedJsonDisplay(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SelectableText(
            _formattedJson,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
