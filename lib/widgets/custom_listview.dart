import 'package:flutter/material.dart';

class CustomListViewHorizontal extends StatelessWidget {
  const CustomListViewHorizontal({
    super.key,
    required this.list,
    required this.child,
  });
  final List<String> list;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                child,
                Text(list[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomListViewVertical extends StatelessWidget {
  const CustomListViewVertical({
    super.key,
    required this.list,
    required this.child,
    required this.ellipsis,
  });

  final List<String> list;
  final Widget child;
  final Widget ellipsis;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              const SizedBox(width: 12),
              Text(
                list[index],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              ellipsis,
            ],
          ),
        );
      },
    );
  }
}
