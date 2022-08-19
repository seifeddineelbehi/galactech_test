import 'package:flutter/cupertino.dart';

abstract class HomeTestRepository {
  TestHome(String test);
}

class HomeTestViewModel with ChangeNotifier implements HomeTestRepository {
  @override
  TestHome(String test) {
    // TODO: implement TestHome
    throw UnimplementedError();
  }
}
