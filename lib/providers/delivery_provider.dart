import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/delivery.dart';

class DeliveryProvider with ChangeNotifier {
  List<Delivery> _deliveries = [];
  
  List<Delivery> get deliveries => _deliveries;
  
  List<Delivery> get pendingDeliveries =>
      _deliveries.where((d) => !d.isCompleted).toList();
  
  List<Delivery> get completedDeliveries =>
      _deliveries.where((d) => d.isCompleted).toList();
  
  int get totalDeliveries => _deliveries.length;
  
  int get completedCount => completedDeliveries.length;
  
  double get completionPercentage =>
      totalDeliveries > 0 ? (completedCount / totalDeliveries) * 100 : 0;

  // Datos simulados iniciales
  List<Delivery> _getInitialDeliveries() {
    return [
      Delivery(
        id: '001',
        customerName: 'María González',
        address: 'Calle Mayor 123, Apto 4B',
        deliveryTime: '10:00 - 11:00',
        riderName: 'Carlos Ruiz',
      ),
      Delivery(
        id: '002',
        customerName: 'Juan Pérez',
        address: 'Av. Libertador 456',
        deliveryTime: '11:00 - 12:00',
        riderName: 'Carlos Ruiz',
      ),
      Delivery(
        id: '003',
        customerName: 'Ana Martínez',
        address: 'Plaza Central 789',
        deliveryTime: '12:00 - 13:00',
        riderName: 'Laura Sánchez',
      ),
      Delivery(
        id: '004',
        customerName: 'Pedro López',
        address: 'Calle del Sol 321',
        deliveryTime: '13:00 - 14:00',
        riderName: 'Laura Sánchez',
      ),
      Delivery(
        id: '005',
        customerName: 'Sofía Ramírez',
        address: 'Av. Principal 654',
        deliveryTime: '14:00 - 15:00',
        riderName: 'Miguel Torres',
      ),
      Delivery(
        id: '006',
        customerName: 'Diego Fernández',
        address: 'Calle Luna 987',
        deliveryTime: '15:00 - 16:00',
        riderName: 'Miguel Torres',
      ),
      Delivery(
        id: '007',
        customerName: 'Elena Castro',
        address: 'Paseo Verde 147',
        deliveryTime: '16:00 - 17:00',
        riderName: 'Carlos Ruiz',
      ),
      Delivery(
        id: '008',
        customerName: 'Roberto Silva',
        address: 'Calle Estrella 258',
        deliveryTime: '17:00 - 18:00',
        riderName: 'Laura Sánchez',
      ),
    ];
  }

  // Cargar entregas desde SharedPreferences
  Future<void> loadDeliveries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? deliveriesJson = prefs.getString('deliveries');
      
      if (deliveriesJson != null) {
        final List<dynamic> decoded = json.decode(deliveriesJson);
        _deliveries = decoded.map((item) => Delivery.fromJson(item)).toList();
      } else {
        // Si no hay datos guardados, usar datos iniciales
        _deliveries = _getInitialDeliveries();
        await _saveDeliveries();
      }
      notifyListeners();
    } catch (e) {
      // Si hay error, usar datos iniciales
      _deliveries = _getInitialDeliveries();
      notifyListeners();
    }
  }

  // Guardar entregas en SharedPreferences
  Future<void> _saveDeliveries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String deliveriesJson = json.encode(
        _deliveries.map((delivery) => delivery.toJson()).toList(),
      );
      await prefs.setString('deliveries', deliveriesJson);
    } catch (e) {
      debugPrint('Error al guardar entregas: $e');
    }
  }

  // Marcar entrega como completada
  Future<void> markAsDelivered(String deliveryId) async {
    final index = _deliveries.indexWhere((d) => d.id == deliveryId);
    if (index != -1) {
      _deliveries[index] = _deliveries[index].copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      await _saveDeliveries();
      notifyListeners();
    }
  }

  // Desmarcar entrega (para poder probar)
  Future<void> markAsPending(String deliveryId) async {
    final index = _deliveries.indexWhere((d) => d.id == deliveryId);
    if (index != -1) {
      _deliveries[index] = _deliveries[index].copyWith(
        isCompleted: false,
        completedAt: null,
      );
      await _saveDeliveries();
      notifyListeners();
    }
  }

  // Resetear todas las entregas (útil para pruebas)
  Future<void> resetDeliveries() async {
    _deliveries = _getInitialDeliveries();
    await _saveDeliveries();
    notifyListeners();
  }

  // Obtener entregas por repartidor
  List<Delivery> getDeliveriesByRider(String riderName) {
    return _deliveries.where((d) => d.riderName == riderName).toList();
  }

  // Obtener lista de repartidores únicos
  List<String> get riders {
    return _deliveries.map((d) => d.riderName).toSet().toList();
  }
}
