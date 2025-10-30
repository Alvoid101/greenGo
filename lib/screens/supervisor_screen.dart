import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../widgets/progress_card.dart';
import '../widgets/rider_performance_card.dart';
import '../widgets/delivery_timeline.dart';

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Supervisor'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Resumen'),
            Tab(icon: Icon(Icons.people), text: 'Repartidores'),
            Tab(icon: Icon(Icons.timeline), text: 'Timeline'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DeliveryProvider>(context, listen: false)
                  .loadDeliveries();
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Resetear entregas'),
                onTap: () {
                  Future.delayed(Duration.zero, () => _showResetDialog());
                },
              ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildRidersTab(),
          _buildTimelineTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Consumer<DeliveryProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () => provider.loadDeliveries(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card de progreso principal
                ProgressCard(
                  total: provider.totalDeliveries,
                  completed: provider.completedCount,
                  percentage: provider.completionPercentage,
                ),
                const SizedBox(height: 24),

                // Estadísticas generales
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Pendientes',
                        value: provider.pendingDeliveries.length.toString(),
                        icon: Icons.pending_actions,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Completadas',
                        value: provider.completedCount.toString(),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Repartidores',
                        value: provider.riders.length.toString(),
                        icon: Icons.pedal_bike,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Total',
                        value: provider.totalDeliveries.toString(),
                        icon: Icons.inventory,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Lista de entregas recientes
                Text(
                  'Entregas Recientes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...provider.deliveries.take(5).map((delivery) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: delivery.isCompleted
                            ? Colors.green
                            : Colors.orange,
                        child: Icon(
                          delivery.isCompleted
                              ? Icons.check
                              : Icons.access_time,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(delivery.customerName),
                      subtitle: Text(delivery.address),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            delivery.deliveryTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            delivery.riderName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRidersTab() {
    return Consumer<DeliveryProvider>(
      builder: (context, provider, child) {
        final riders = provider.riders;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: riders.length,
          itemBuilder: (context, index) {
            final rider = riders[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RiderPerformanceCard(
                riderName: rider,
                deliveries: provider.getDeliveriesByRider(rider),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimelineTab() {
    return Consumer<DeliveryProvider>(
      builder: (context, provider, child) {
        return DeliveryTimeline(deliveries: provider.deliveries);
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resetear entregas'),
        content: const Text(
          '¿Estás seguro de que quieres resetear todas las entregas a su estado inicial?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<DeliveryProvider>(context, listen: false)
                  .resetDeliveries();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Entregas reseteadas correctamente'),
                ),
              );
            },
            child: const Text('Resetear'),
          ),
        ],
      ),
    );
  }
}
