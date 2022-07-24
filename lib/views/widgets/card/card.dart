import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/common/const.dart';
import 'package:news_app/models/item_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.data,
    required this.navigationFunc,
  }) : super(key: key);
  final ItemModel data;
  final Function navigationFunc;

  @override
  Widget build(BuildContext context) {
    String createDateString = "";
    if (data.publishedAt != null) {
      try {
        DateTime createDate = DateTime.parse(data.publishedAt!);
        createDateString = dateFormat.format(createDate);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return GestureDetector(
      onTap: () {
        navigationFunc();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                data.author ?? "no_author",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  createDateString,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10),
            child: Text(
              data.title ?? "no_title",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
