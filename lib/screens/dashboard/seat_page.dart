import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String _selectedZone = 'All';
  int? _selectedSeat;

  // Seat data: 0=available, 1=occupied, 2=reserved
  final List<int> _seats = [
    0, 1, 0, 0, 1, 1, 0, 0, // Row A
    1, 0, 0, 1, 0, 0, 1, 0, // Row B
    0, 0, 1, 0, 0, 1, 0, 0, // Row C
    0, 1, 0, 0, 1, 0, 0, 1, // Row D
    0, 0, 0, 1, 0, 0, 0, 1, // Row E
    1, 0, 0, 0, 0, 1, 0, 0, // Row F
  ];

  final List<String> _zones = ['All', 'Zone A', 'Zone B', 'Zone C'];

  int get _available => _seats.where((s) => s == 0).length;
  int get _occupied => _seats.where((s) => s == 1).length;
  int get _total => _seats.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        title: const Text('Seat Availability'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Last updated: now',
              style: TextStyle(
                color: Color(0xFF8A7570),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats row
            Row(
              children: [
                _statCard(
                  '🟢',
                  'Available',
                  '$_available',
                  const Color(0xFFE8F5E9),
                  Colors.green,
                ),
                const SizedBox(width: 16),
                _statCard(
                  '🔴',
                  'Occupied',
                  '$_occupied',
                  const Color(0xFFFCE4EC),
                  Colors.red,
                ),
                const SizedBox(width: 16),
                _statCard(
                  '🪑',
                  'Total Seats',
                  '$_total',
                  const Color(0xFFFFF3E0),
                  const Color(0xFFE8470A),
                ),
                const SizedBox(width: 16),
                _statCard(
                  '📊',
                  'Occupancy',
                  '${(_occupied / _total * 100).round()}%',
                  const Color(0xFFE3F2FD),
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 28),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Floor plan
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Canteen Floor Plan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF1A0F0A),
                              ),
                            ),
                            // Zone filter
                            Row(
                              children: _zones.map((z) {
                                final sel = _selectedZone == z;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedZone = z),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: sel
                                            ? const Color(0xFFE8470A)
                                            : const Color(0xFFF5EDE8),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        z,
                                        style: TextStyle(
                                          color: sel
                                              ? Colors.white
                                              : const Color(0xFF8A7570),
                                          fontSize: 12,
                                          fontWeight: sel
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Counter bar at top
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A0F0A),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              '🍽️  SERVICE COUNTER',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Seat grid
                        ...List.generate(6, (row) {
                          final rowLabel =
                              String.fromCharCode(65 + row); // A-F
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  child: Text(
                                    rowLabel,
                                    style: const TextStyle(
                                      color: Color(0xFF8A7570),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    children: List.generate(8, (col) {
                                      final idx = row * 8 + col;
                                      final status = _seats[idx];
                                      final selected =
                                          _selectedSeat == idx;

                                      // Aisle after seat 3
                                      return Row(
                                        children: [
                                          if (col == 4)
                                            const SizedBox(width: 20),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: status == 0
                                                  ? () => setState(() =>
                                                      _selectedSeat = idx)
                                                  : null,
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                margin:
                                                    const EdgeInsets.only(
                                                        right: 6),
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color: selected
                                                      ? const Color(
                                                          0xFFE8470A)
                                                      : status == 0
                                                          ? Colors.green
                                                              .shade100
                                                          : Colors.red
                                                              .shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  border: Border.all(
                                                    color: selected
                                                        ? const Color(
                                                            0xFFE8470A)
                                                        : status == 0
                                                            ? Colors.green
                                                                .shade300
                                                            : Colors.red
                                                                .shade200,
                                                    width: selected ? 2 : 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.event_seat_rounded,
                                                    size: 20,
                                                    color: selected
                                                        ? Colors.white
                                                        : status == 0
                                                            ? Colors.green
                                                                .shade700
                                                            : Colors.red
                                                                .shade300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 8),

                        // Legend
                        Row(
                          children: [
                            _legendDot(Colors.green.shade300, 'Available'),
                            const SizedBox(width: 20),
                            _legendDot(Colors.red.shade200, 'Occupied'),
                            const SizedBox(width: 20),
                            _legendDot(
                                const Color(0xFFE8470A), 'Your Selection'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 24),

                // Seat detail panel
                SizedBox(
                  width: 260,
                  child: Column(
                    children: [
                      // Occupancy meter
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE8470A), Color(0xFFFF7043)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Live Occupancy',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(_occupied / _total * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: _occupied / _total,
                                backgroundColor: Colors.white24,
                                color: Colors.white,
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$_available seats free out of $_total',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Selected seat info
                      if (_selectedSeat != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selected Seat',
                                style: TextStyle(
                                  color: Color(0xFF8A7570),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${String.fromCharCode(65 + (_selectedSeat! ~/ 8))}${(_selectedSeat! % 8) + 1}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE8470A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '📍 Near window • Ground floor',
                                style: TextStyle(
                                  color: Color(0xFF8A7570),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: const Text('Seat Reserved!'),
                                        content: Text(
                                          'Seat ${String.fromCharCode(65 + (_selectedSeat! ~/ 8))}${(_selectedSeat! % 8) + 1} has been reserved for 15 minutes.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Color(0xFFE8470A)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('Reserve Seat'),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    setState(() => _selectedSeat = null),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Color(0xFF8A7570)),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              Text('🪑',
                                  style: TextStyle(fontSize: 40)),
                              SizedBox(height: 12),
                              Text(
                                'Tap a green seat\nto select it',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF8A7570),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Zone breakdown
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Zone Breakdown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF1A0F0A),
                              ),
                            ),
                            const SizedBox(height: 14),
                            _zoneRow('Zone A (Rows A-B)', 10, 16),
                            const SizedBox(height: 10),
                            _zoneRow('Zone B (Rows C-D)', 8, 16),
                            const SizedBox(height: 10),
                            _zoneRow('Zone C (Rows E-F)', 12, 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String emoji, String label, String value, Color bg,
      Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF8A7570),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF8A7570), fontSize: 12),
        ),
      ],
    );
  }

  Widget _zoneRow(String label, int free, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style:
                  const TextStyle(color: Color(0xFF8A7570), fontSize: 12),
            ),
            Text(
              '$free/$total free',
              style: TextStyle(
                color: free > total ~/ 2
                    ? Colors.green.shade700
                    : Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (total - free) / total,
            backgroundColor: Colors.green.shade100,
            color: Colors.red.shade300,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
