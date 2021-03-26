import 'package:flutter/material.dart';
import 'package:ramen/common/result_state.dart';
import 'package:ramen/data/local/database_helper.dart';
import 'package:ramen/data/model/ramen.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}){
    _getAllRamen();
  }

  ResultState _state;
  ResultState get state => _state;
 
  String _message = '';
  String get message => _message;
 
  List<Ramen> _ramens = [];
  List<Ramen> get ramen => _ramens;

  void getAllRamen(){
    _getAllRamen();
  }

  void _getAllRamen() async {
    _state = ResultState.Loading;
    notifyListeners();
    _ramens = await databaseHelper.getRamen();
    if (_ramens.length > 0) {
      _state = ResultState.HasData;
      notifyListeners();
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
      notifyListeners();
    }
  }

  Future<void> addRamen(Ramen ramen) async {
    try {
      await databaseHelper.insertRamen(ramen);
      _getAllRamen();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Can\'t save ramen';
      notifyListeners();
    }
  }

  void updateRamen(Ramen ramen) async {
    await databaseHelper.updateRamen(ramen);
    _getAllRamen();
  }

  void deleteRamen(int id) async {
    try {
      await databaseHelper.deleteRamen(id);
      _getAllRamen();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Can\'t save ramen';
      notifyListeners();
    }
  }
  
  Future<int> checkRamenName(String name) async{
    return await databaseHelper.checkRamenName(name);
  }
}
