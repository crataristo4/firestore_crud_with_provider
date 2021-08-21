import 'package:firestore_crud_with_provider/model/names.dart';
import 'package:flutter/foundation.dart';

class NameProvider with ChangeNotifier {
  List<Names> namesList = [];

  void addNames(String name) {
    Names newName = Names(name: name);
    namesList.add(newName);

    notifyListeners();
  }
}
