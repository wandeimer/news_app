import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/home/search_cubit.dart';
import 'package:news_app/models/item_model.dart';
import 'package:news_app/views/widgets/card/card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NEWS")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: myController,
              onSubmitted: (text) {},
              onChanged: (text) {
                context.read<SearchCubit>().searchNews(
                      request: text,
                    );
              },
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: -0.14,
                fontWeight: FontWeight.w500,
                height: 1.21,
              ),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15, right: 10, top: 15),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    letterSpacing: -0.14,
                    fontWeight: FontWeight.w500,
                    height: 1.21,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 27,
                    maxWidth: 50,
                    minHeight: 27,
                    minWidth: 50,
                  ),
                  suffixIcon: const Icon(Icons.search)),
            ),
          ),
          BlocBuilder<SearchCubit, SearchState>(builder: (context, snapshot) {
            if (snapshot is SearchLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xfffea3a0),
                )),
              );
            } else if (snapshot is SearchLoaded<List<ItemModel>?>) {
              if (snapshot.data == null) {
                return const Text("ERROR LOADING NEWS");
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      // todo lasy load
                      // if (index == snapshot.data!.length) {
                      //   context.read<SearchCubit>().loadMoreNews();
                      //   return const Center(
                      //       child: CircularProgressIndicator(
                      //   ));
                      // }
                      return NewsCard(data: snapshot.data![index]);
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
