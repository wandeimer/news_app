import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/models/item_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.data}) : super(key: key);
  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post")),
    );
  }
}
