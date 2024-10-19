import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        Image.network(
            'https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fchoiwooseok.github.io&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false'),
        const SizedBox(width: 10),
        IconButton(
          tooltip: 'Menu',
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(47.0);
}
