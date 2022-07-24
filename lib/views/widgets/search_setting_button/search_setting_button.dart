import 'package:flutter/material.dart';

class SearchSettingButton extends StatelessWidget {
  const SearchSettingButton({
    Key? key,
    required this.title,
    required this.text,
    required this.func,
  }) : super(key: key);
  final String title;
  final String text;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          func();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: -0.14,
                      fontWeight: FontWeight.w500,
                      height: 1.21,
                    ),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: -0.14,
                      fontWeight: FontWeight.w500,
                      height: 1.21,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
