import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../widgets/delivery_card.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({super.key});

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  String? selectedRider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Repartidor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DeliveryProvider>(context, listen: false)
                  .loadDeliveries();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lista actualizada')),
              );
            },
          ),
        ],
      ),
      body: Consumer<DeliveryProvider>(
        builder: (context, provider, child) {
          final riders = provider.riders;

          return Column(
            children: [
              // Selector de repartidor
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecciona tu perfil',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRider,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      hint: const Text('Selecciona tu nombre'),
                      items: riders.map((rider) {
                        return DropdownMenuItem(
                          value: rider,
                          child: Text(rider),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRider = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Estadísticas del repartidor
              if (selectedRider != null) ...[
                _buildRiderStats(context, provider),
              ],

              // Lista de entregas
              Expanded(
                child: selectedRider == null
                    ? _buildEmptyState()
                    : _buildDeliveryList(context, provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRiderStats(BuildContext context, DeliveryProvider provider) {
    final riderDeliveries = provider.getDeliveriesByRider(selectedRider!);
    final completed = riderDeliveries.where((d) => d.isCompleted).length;
    final pending = riderDeliveries.length - completed;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            icon: Icons.pending_actions,
            label: 'Pendientes',
            value: pending.toString(),
            color: Colors.white,
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white30,
          ),
          _buildStatItem(
            context,
            icon: Icons.check_circle,
            label: 'Completadas',
            value: completed.toString(),
            color: Colors.white,
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white30,
          ),
          _buildStatItem(
            context,
            icon: Icons.local_shipping,
            label: 'Total',
            value: riderDeliveries.length.toString(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryList(BuildContext context, DeliveryProvider provider) {
    final deliveries = provider.getDeliveriesByRider(selectedRider!);
    final pendingDeliveries = deliveries.where((d) => !d.isCompleted).toList();
    final completedDeliveries = deliveries.where((d) => d.isCompleted).toList();

    if (deliveries.isEmpty) {
      return _buildEmptyState(message: 'No tienes entregas asignadas');
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pendingDeliveries.isNotEmpty) ...[
          Text(
            'Entregas Pendientes (${pendingDeliveries.length})',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 12),
          ...pendingDeliveries.map((delivery) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DeliveryCard(
                  delivery: delivery,
                  onToggleComplete: () {
                    provider.markAsDelivered(delivery.id);
                    _showSuccessAnimation(context);
                  },
                ),
              )),
          const SizedBox(height: 24),
        ],
        if (completedDeliveries.isNotEmpty) ...[
          Text(
            'Entregas Completadas (${completedDeliveries.length})',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 12),
          ...completedDeliveries.map((delivery) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DeliveryCard(
                  delivery: delivery,
                  onToggleComplete: () {
                    provider.markAsPending(delivery.id);
                  },
                ),
              )),
        ],
      ],
    );
  }

  Widget _buildEmptyState({String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Selecciona un repartidor para ver sus entregas',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showSuccessAnimation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('¡Entrega completada con éxito!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
