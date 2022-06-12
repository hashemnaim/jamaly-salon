import 'package:flutter/material.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CheackBoxScreen extends StatefulWidget {
  final String title;
  final bool index;


  const CheackBoxScreen({this.title,this.index});

  @override
  _CheackBoxScreenState createState() => _CheackBoxScreenState();
}

class _CheackBoxScreenState extends State<CheackBoxScreen> {
  bool valueC=false;

  setValue(bool value){
    this.valueC=value;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: true,
      contentPadding: EdgeInsets.all(0),
      title: CustomText(
        widget.title,
        alignment: AlignmentDirectional.centerStart,
      ),
      onChanged: (val) {},
    );
  }
}
