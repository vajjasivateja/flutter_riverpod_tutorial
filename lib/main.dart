import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/User.dart';
import 'package:flutter_riverpod_tutorial/home_screen.dart';
import 'package:flutter_riverpod_tutorial/home_screen_two.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//Provider
final nameProvider = Provider<String>((ref) => "Siva Teja");

//State provider can be used to update the value of a provider from outside
final nameStateProvider = StateProvider<String?>((ref) => null);

//StateNotifier and StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

//ChangeNotifier and ChangeNotifierProvider
final userChangeNotifierProvider = ChangeNotifierProvider((ref) => UserNotifierChange());

//FutureProvider
final fetchUserProvider = FutureProvider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.fetchUserData();
});

//FutureProvider with family
final fetchUserByIdProvider = FutureProvider.family.autoDispose((ref, String input) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.fetchUserDataById(input);
});


final streamProvider = StreamProvider((ref) async* {
  yield [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
});

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FutureProvideWithFamilyExample(),
    );
  }
}
