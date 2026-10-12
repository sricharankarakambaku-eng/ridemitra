import 'package:flutter/material.dart';

void main() => runApp(const RideMitraApp());

const brand = Color(0xFFFFC928);
const ink = Color(0xFF171717);

class RideMitraApp extends StatelessWidget {
  const RideMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideMitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brand),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: brand,
          foregroundColor: ink,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  String selectedRole = 'Passenger';
  String rideStatus = 'No ride requested';
  int estimatedFare = 0;
  final List<String> rideHistory = [];

  @override
  void dispose() {
    pickupController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  void estimateFare() {
    if (pickupController.text.trim().isEmpty ||
        destinationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter both pickup and destination.')),
      );
      return;
    }
    setState(() {
      estimatedFare = 40; // Demo-only fare; not distance-based.
      rideStatus = 'Fare estimate ready';
    });
  }

  void requestRide() {
    if (pickupController.text.trim().isEmpty ||
        destinationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter pickup and destination first.')),
      );
      return;
    }
    setState(() {
      estimatedFare = estimatedFare == 0 ? 40 : estimatedFare;
      rideStatus = 'Demo request created — no driver has been contacted';
      rideHistory.insert(
        0,
        '${pickupController.text.trim()} → ${destinationController.text.trim()} • ₹$estimatedFare • Demo',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.two_wheeler, size: 30),
            SizedBox(width: 8),
            Text('RideMitra', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Choose app role',
            initialValue: selectedRole,
            onSelected: (value) => setState(() => selectedRole = value),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Passenger', child: Text('Passenger mode')),
              PopupMenuItem(value: 'Driver', child: Text('Driver mode')),
              PopupMenuItem(value: 'Admin', child: Text('Admin preview')),
            ],
            icon: const Icon(Icons.account_circle, size: 28),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ink,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('YOUR RIDE, YOUR WAY',
                    style: TextStyle(
                      color: brand,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 8),
                Text('Move around with RideMitra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 6),
                Text(
                  'V1 starter app • India launch concept',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$selectedRole mode',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  TextField(
                    controller: pickupController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.my_location),
                      labelText: 'Pickup location',
                      hintText: 'e.g. Ameerpet Metro Station',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: destinationController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      labelText: 'Destination',
                      hintText: 'e.g. Hyderabad Central University',
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: estimateFare,
                          icon: const Icon(Icons.currency_rupee),
                          label: const Text('Estimate fare'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: brand,
                            foregroundColor: ink,
                          ),
                          onPressed: requestRide,
                          icon: const Icon(Icons.two_wheeler),
                          label: const Text('Request ride'),
                        ),
                      ),
                    ],
                  ),
                  if (estimatedFare > 0) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4C7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Demo fare: ₹$estimatedFare\\n'
                        'Illustrative fixed amount only; not a real quote.',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF0B0),
                child: Icon(Icons.info_outline, color: ink),
              ),
              title: const Text('Ride status'),
              subtitle: Text(rideStatus),
            ),
          ),
          if (selectedRole == 'Driver')
            Card(
              elevation: 0,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Driver preview\\n\\n'
                  'Driver onboarding, document verification, online status, '
                  'and accepting real requests will be connected in a later version.',
                ),
              ),
            ),
          if (selectedRole == 'Admin')
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Admin preview',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Demo ride requests in this session: ${rideHistory.length}'),
                    const SizedBox(height: 6),
                    const Text(
                      'This is not a secure admin system yet. Real admin access must be enforced by a backend.',
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 14),
          const Text('Recent demo requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (rideHistory.isEmpty)
            const Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Your demo ride requests will appear here.'),
              ),
            )
          else
            ...rideHistory.map(
              (item) => Card(
                elevation: 0,
                child: ListTile(
                  leading: const Icon(Icons.route),
                  title: Text(item),
                ),
              ),
            ),
          const SizedBox(height: 16),
          const Text(
            'Prototype only: this version does not connect to real drivers, GPS, maps, payments, or emergency services. Do not use it to arrange real rides.',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
