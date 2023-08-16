import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void onSubmit(WidgetRef ref, String value) {
    //read stateNotifier example
    //2nd way used to read the global provider just ones, not recommended to use in build method, but out side build method.
    ref.read(userProvider.notifier).updateUserName(value);
  }

  void onSubmitEmail(WidgetRef ref, String value) {
    //read change notifier example
    ref.read(userChangeNotifierProvider).updateUserName(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //1st way used to continuously keep listening for any changes in global provider, recommended to use in build method, but not  out side build method.
    // this will rebuild the widget every time when even any of the data changes in the provider
    final name = ref.watch(nameProvider);
    final nameState = ref.watch(nameStateProvider) ?? "";
    final userNotifier = ref.watch(userProvider);
    //3rd way used only if you want to rebuild the widget only if any particular data is updated in the global provider
    final userSelect = ref.watch(userProvider.select((value) => value.name));
    final userChangeNotifier = ref.watch(userChangeNotifierProvider).user;

    //future provider
    final userFuture = ref.watch(fetchUserProvider);
    return userFuture.when(data: (data) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(data.name.toString()),
          ),
          body: Column(
            children: [
              TextField(
                onSubmitted: (value) => onSubmit(ref, value),
              ),
              TextField(
                onSubmitted: (value) => onSubmitEmail(ref, value),
              ),
              Text(data.email.toString()),
            ],
          ),
        ),
      );
    }, error: (error, stacktrace) {
      return SafeArea(
        child: Scaffold(
          body: Center(child: Text(error.toString())),
        ),
      );
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });
  }
}

class HomeScreenStatefulWidget extends ConsumerStatefulWidget {
  const HomeScreenStatefulWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreenStatefulWidget> createState() => _HomeScreenStatefulWidgetState();
}

class _HomeScreenStatefulWidgetState extends ConsumerState<HomeScreenStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(streamProvider).when(data: (data) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [Text(data.toString())],
          ),
        ),
      );
    }, error: (error, stacktrace) {
      return SafeArea(
        child: Scaffold(
          body: Center(child: Text(error.toString())),
        ),
      );
    }, loading: () {
      return const SafeArea(
        child: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }
}

class FutureProvideWithFamilyExample extends ConsumerStatefulWidget {
  const FutureProvideWithFamilyExample({Key? key}) : super(key: key);

  @override
  ConsumerState<FutureProvideWithFamilyExample> createState() => _FutureProvideWithModifierExampleState();
}

class _FutureProvideWithModifierExampleState extends ConsumerState<FutureProvideWithFamilyExample> {
  String userInput = "1";

  @override
  Widget build(BuildContext context) {
    final userFuture = ref.watch(fetchUserByIdProvider(userInput));
    return userFuture.when(data: (data) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(data.name.toString()),
          ),
          body: Column(
            children: [
              TextField(
                  onSubmitted: (value) => setState(() {
                        userInput = value.toString();
                      })),
              Text(data.email.toString()),
            ],
          ),
        ),
      );
    }, error: (error, stacktrace) {
      return SafeArea(
        child: Scaffold(
          body: Center(child: Text(error.toString())),
        ),
      );
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });
  }
}

