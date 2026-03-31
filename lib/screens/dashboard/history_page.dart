import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#B247',
      'date': 'Today, 12:30 PM',
      'items': ['Masala Dosa', 'Samosa (2pc)', 'Cold Coffee'],
      'total': 115,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B231',
      'date': 'Yesterday, 1:15 PM',
      'items': ['Veg Thali', 'Mango Lassi'],
      'total': 120,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B220',
      'date': '29 Mar, 11:00 AM',
      'items': ['Poha', 'Masala Chai'],
      'total': 40,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B209',
      'date': '28 Mar, 2:00 PM',
      'items': ['Paneer Butter Masala', 'Puri Bhaji', 'Thums Up'],
      'total': 160,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B198',
      'date': '27 Mar, 12:45 PM',
      'items': ['Chole Bhature', 'Lemon Soda'],
      'total': 90,
      'status': 'Cancelled',
      'emoji': '❌',
    },
    {
      'id': '#B185',
      'date': '26 Mar, 1:00 PM',
      'items': ['Veg Biryani', 'Cold Coffee'],
      'total': 125,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B174',
      'date': '25 Mar, 11:30 AM',
      'items': ['Bread Sandwich', 'Coca-Cola'],
      'total': 60,
      'status': 'Delivered',
      'emoji': '✅',
    },
    {
      'id': '#B162',
      'date': '24 Mar, 3:00 PM',
      'items': ['French Fries', 'Mirinda'],
      'total': 63,
      'status': 'Delivered',
      'emoji': '✅',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 'All') return _orders;
    return _orders.where((o) => o['status'] == _selectedFilter).toList();
  }

  int get _monthTotal =>
      _orders.fold(0, (a, o) => a + (o['total'] as int));
  int get _deliveredCount =>
      _orders.where((o) => o['status'] == 'Delivered').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        title: const Text('Order History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main list
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter chips
                  Row(
                    children: ['All', 'Delivered', 'Cancelled']
                        .map((f) {
                      final sel = _selectedFilter == f;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFilter = f),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: sel
                                  ? const Color(0xFFE8470A)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel
                                    ? const Color(0xFFE8470A)
                                    : const Color(0xFFE0D5CF),
                              ),
                            ),
                            child: Text(
                              f,
                              style: TextStyle(
                                color: sel
                                    ? Colors.white
                                    : const Color(0xFF8A7570),
                                fontWeight: sel
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    '${_filtered.length} orders',
                    style: const TextStyle(
                      color: Color(0xFF8A7570),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: ListView.separated(
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (_, i) =>
                          _orderCard(_filtered[i]),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            // Summary sidebar
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  // Month stats
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
                          'March 2026',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Monthly Summary',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _summaryRow('Total Orders', '${_orders.length}'),
                        const SizedBox(height: 10),
                        _summaryRow('Completed', '$_deliveredCount'),
                        const SizedBox(height: 10),
                        _summaryRow('Amount Spent', '₹$_monthTotal'),
                        const SizedBox(height: 10),
                        _summaryRow('Avg per Order',
                            '₹${(_monthTotal / _orders.length).round()}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Favourite items
                  Container(
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
                          '🔥 Most Ordered',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF1A0F0A),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _favItem('🫓', 'Masala Dosa', 5),
                        const SizedBox(height: 10),
                        _favItem('🍱', 'Veg Thali', 4),
                        const SizedBox(height: 10),
                        _favItem('☕', 'Cold Coffee', 6),
                        const SizedBox(height: 10),
                        _favItem('🥟', 'Samosa', 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order) {
    final delivered = order['status'] == 'Delivered';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                order['id'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1A0F0A),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: delivered
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      order['emoji'],
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order['status'],
                      style: TextStyle(
                        color: delivered
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                order['date'],
                style: const TextStyle(
                  color: Color(0xFF8A7570),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            (order['items'] as List).join(' • '),
            style: const TextStyle(
              color: Color(0xFF8A7570),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '₹${order['total']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8470A),
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              if (delivered)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    backgroundColor: const Color(0xFFFFF3E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Reorder',
                    style: TextStyle(
                      color: Color(0xFFE8470A),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _favItem(String emoji, String name, int count) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1A0F0A),
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${count}x',
            style: const TextStyle(
              color: Color(0xFFE8470A),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
