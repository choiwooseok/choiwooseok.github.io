import 'package:flutter/material.dart';

class PageDrawer extends StatelessWidget {
  const PageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text('Pages', style: TextStyle(color: Colors.white)),
            ),
          ),
          ListTile(
            title: const Text(
              'Lottery Number Generator',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/lotto_number_generator',
              );
            },
          ),
          ListTile(
            title: const Text(
              'JSON Formatter',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/json_formatter',
              );
            },
          ),
        ],
      ),
    );
  }
}
