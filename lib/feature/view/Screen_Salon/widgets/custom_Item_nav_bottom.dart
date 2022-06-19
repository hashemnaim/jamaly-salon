import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarItem {
  final Widget icon;
  final String titel;
  final bool hasNotification;

  CustomAppBarItem({this.icon, this.hasNotification = false, this.titel});
}

class CustomBottomAppBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;

  CustomBottomAppBar({this.onTabSelected, this.items});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  AppGet appGet = Get.find();

  void _updateIndex(index) {
    widget.onTabSelected(index);
    setState(() {
      appGet.setindexNav(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabIcon(
          index: index, item: widget.items[index], onPressed: _updateIndex);
    });

    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]),
        ),
        height: 50.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            //  mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items,
          ),
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _buildTabIcon(
      {int index, CustomAppBarItem item, ValueChanged<int> onPressed}) {
    return InkWell(onTap: () => onPressed(index), child: item.icon);
  }
}
