import 'package:flutter/material.dart';
import '../database/plan_database.dart';
import '../models/plan_model.dart';

class PlanNotifier extends ChangeNotifier {
  final PlanDatabase _dbPlan = PlanDatabase();
  List<Plan> _planes = [];
  Plan? _selectedPlan;

  List<Plan> get planes => _planes;
  Plan? get selectedPlan => _selectedPlan;

  PlanNotifier(){
    _fetchPlan();
  }

  Future<void> _fetchPlan() async {
    _planes = await _dbPlan.getPlan();
    notifyListeners();
  }

  Future<void> savePlan(Plan plan) async {
    if (plan.id == null) {
      await _dbPlan.insertPlan(plan);
    } else {
      await _dbPlan.updatePlan(plan);
    }
    await _fetchPlan();
    clearForm();
  }

  void clearForm() {
    _selectedPlan = null;
    notifyListeners();
  }

  Future<void> deletePlan(int id) async {
    await _dbPlan.deletePlan(id);
    await _fetchPlan();
  }

  void selectPlan(Plan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  Future<void> searchPlan(String query) async {
    if(query.isEmpty){
      _fetchPlan();
    } else {
      final filteredPlanes = _planes.where((plan) {
        final lineaNombre = plan.nombre.toLowerCase();
        final searchLower = query.toLowerCase();
        return lineaNombre.contains(searchLower);
      }).toList();
      _planes = filteredPlanes;
      notifyListeners();
    }
  }
}
