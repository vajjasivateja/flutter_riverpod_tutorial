import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/main.dart';

class HomeScreenTwo extends StatelessWidget {
  const HomeScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, ref, child) {
          final name = ref.watch(nameProvider);
          //used to continuously keep listening for any changes in global provider, recommended to use in build method, but not  out side build method.
          //used to read the global provider just ones, not recommended to use in build method, but out side build method.
          final nameRead = ref.read(nameProvider);
          return Column(
            children: [Text(name)],
          );
        }),
      ),
    );
  }
}

