import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:news_app/common/const.dart';
import 'package:news_app/models/item_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.data}) : super(key: key);
  final ItemModel data;

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
    return Scaffold(
      appBar: AppBar(title: const Text("Post")),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.title ?? "no_title",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
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
              ),
              // note
              // i did not set size of image, because api not guarantee image orientation
              // so, variable image size can show both orientation good in this case
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                child: data.urlToImage != null
                    ? Image.network(
                        data.urlToImage!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator(
                            color: Color(0xfffea3a0),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("NO IMAGE");
                        },
                      )
                    : const Text("NO IMAGE"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  data.description ?? "no_title",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Linkify(
                  text: data.url!,
                  onOpen: (link) async {
                    if (await canLaunchUrl(Uri.parse(link.url))) {
                      await launchUrl(Uri.parse(link.url));
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
