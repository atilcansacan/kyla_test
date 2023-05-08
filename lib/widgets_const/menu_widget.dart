import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      reverse: true,
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return Center(
            child: menuItem(context, menuItems[index], menuItems.length));
      },
    );
  }

  Widget menuItem(
    BuildContext context,
    String item,
    int itemCount,
  ) {
    Size size = MediaQuery.of(context).size;
    var padding = menuItems.length < 8
        ? size.height / itemCount * 0.25
        : size.height / itemCount * 0.4;
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

List<String> menuItems = [
  'Text Note',
  'Attachment',
  'Camera',
  'Reminder',
];
