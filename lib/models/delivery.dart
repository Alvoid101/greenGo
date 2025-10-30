class Delivery {
  final String id;
  final String customerName;
  final String address;
  final String deliveryTime;
  final String riderName;
  bool isCompleted;
  DateTime? completedAt;

  Delivery({
    required this.id,
    required this.customerName,
    required this.address,
    required this.deliveryTime,
    required this.riderName,
    this.isCompleted = false,
    this.completedAt,
  });

  // Convertir a Map para SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'address': address,
      'deliveryTime': deliveryTime,
      'riderName': riderName,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  // Crear desde Map
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      customerName: json['customerName'],
      address: json['address'],
      deliveryTime: json['deliveryTime'],
      riderName: json['riderName'],
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  // Copiar con cambios
  Delivery copyWith({
    String? id,
    String? customerName,
    String? address,
    String? deliveryTime,
    String? riderName,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Delivery(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      riderName: riderName ?? this.riderName,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
