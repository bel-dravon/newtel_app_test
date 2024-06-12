import 'package:flutter/foundation.dart';
import '../models/linea_model.dart';
import '../database/linea_database.dart';

class LineaNotifier with ChangeNotifier{
  final LineaDatabase _dbLinea = LineaDatabase();
  List<Linea> _lineas = [];
  Linea? _selectedLinea;

  List<Linea> get lineas => _lineas;
  Linea? get selectedLinea => _selectedLinea;

  LineaNotifier(){
    _fetchLineas();
  }

  Future<void> _fetchLineas() async{
    _lineas = await _dbLinea.getLinea();
    notifyListeners();
  }

  Future<void> saveLinea (Linea linea) async{
    if(_selectedLinea == null){
      await _dbLinea.insertLinea(linea);
    }else{
      await _dbLinea.updateLinea(linea);
    }

    _fetchLineas();
    clearForm();
  }

  void clearForm(){
    _selectedLinea = null;
    notifyListeners();
  }

  Future<void> deleteLinea(int id) async{
    await _dbLinea.deleteLinea(id);
    _fetchLineas();
  }

  void selectLinea(Linea linea){
    _selectedLinea = linea;
    notifyListeners();
  }

  void searchLinea(String query){
    if(query.isEmpty){
      _fetchLineas();
    } else {
      final filteredLineas = _lineas.where((linea) {
        final lineaNombre = linea.nombre.toLowerCase();
        final searchLower = query.toLowerCase();
        return lineaNombre.contains(searchLower);
      }).toList();
      _lineas = filteredLineas;
      notifyListeners();
    }
  }

}