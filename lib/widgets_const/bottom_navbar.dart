import 'package:flutter/material.dart';
import 'package:kyla_test/widgets_const/const_values.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    navigationBarItemIcons(Icons.storefront),
                    navigationBarItemIcons(Icons.search),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    navigationBarItemIcons(Icons.bolt),
                    navigationBarItemIcons(Icons.menu_outlined),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationBarItemIcons(IconData icon) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {},
      child: Icon(
        icon,
        color: menuItemColor,
        size: 36,
      ),
    );
  }
}
