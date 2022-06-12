import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImgeView extends StatelessWidget {
  final String imageFile;

  const ImgeView({this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            child: CachedNetworkImage(
              imageUrl: imageFile
              )
          ),
        ),
      ),
      
    );
  }
}