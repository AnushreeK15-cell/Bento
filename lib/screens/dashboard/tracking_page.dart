import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;
  int _currentStep = 1; // 0=Placed, 1=Accepted, 2=Preparing, 3=Ready

  final List<Map<String, dynamic>> _steps = [
    {
      'label': 'Order Placed',
      'desc': 'Your order has been received',
      'icon': Icons.receipt_long_rounded,
      'time': '12:30 PM',
    },
    {
      'label': 'Order Accepted',
      'desc': 'Canteen has confirmed your order',
      'icon': Icons.check_circle_rounded,
      'time': '12:31 PM',
    },
    {
      'label': 'Preparing',
      'desc': 'Your food is being prepared',
      'icon': Icons.restaurant_rounded,
      'time': 'In progress…',
    },
    {
      'label': 'Ready for Pickup',
      'desc': 'Head to Counter 3 to collect',
      'icon': Icons.storefront_rounded,
      'time': '~12:43 PM',
    },
  ];

  final List<Map<String, dynamic>> _orderItems = [
    {'name': 'Masala Dosa', 'qty': 1, 'price': 45, 'emoji': '🫓'},
    {'name': 'Samosa (2pc)', 'qty': 2, 'price': 20, 'emoji': '🥟'},
    {'name': 'Cold Coffee', 'qty': 1, 'price': 35, 'emoji': '☕'},
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  int get _total =>
      _orderItems.fold(0, (a, i) => a + (i['price'] as int) * (i['qty'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        title: const Text('Live Tracking'),
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
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Transform.scale(
                    scale: _pulse.value,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tracking stepper
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  // ETA card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE8470A), Color(0xFFFF7043)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Estimated Ready in',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '12',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                ' min',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pickup at Counter 3',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Mini progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: (_currentStep + 1) / _steps.length,
                            backgroundColor: Colors.white24,
                            color: Colors.white,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${((_currentStep + 1) / _steps.length * 100).round()}% complete',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Step tracker
                  Container(
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
                        const Text(
                          'Order Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1A0F0A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(_steps.length, (i) {
                          final done = i <= _currentStep;
                          final active = i == _currentStep;
                          return _stepRow(
                            _steps[i],
                            done: done,
                            active: active,
                            isLast: i == _steps.length - 1,
                          );
                        }),
                        const SizedBox(height: 16),

                        // Simulate button for demo
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              if (_currentStep < _steps.length - 1) {
                                setState(() => _currentStep++);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFE8470A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Simulate Next Step →',
                              style:
                                  TextStyle(color: Color(0xFFE8470A)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            // Order details side
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  // Token number card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A0F0A),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Token Number',
                          style: TextStyle(
                            color: Color(0xFF8A7570),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '#B247',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8470A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Show at counter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Order items
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
                          'Your Order',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1A0F0A),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ..._orderItems.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Text(item['emoji'],
                                      style:
                                          const TextStyle(fontSize: 22)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFF1A0F0A),
                                          ),
                                        ),
                                        Text(
                                          'x${item['qty']}',
                                          style: const TextStyle(
                                            color: Color(0xFF8A7570),
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${(item['price'] as int) * (item['qty'] as int)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE8470A),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Paid',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1A0F0A),
                              ),
                            ),
                            Text(
                              '₹$_total',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8470A),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
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

  Widget _stepRow(
    Map<String, dynamic> step, {
    required bool done,
    required bool active,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: done
                      ? const Color(0xFFE8470A)
                      : const Color(0xFFF5EDE8),
                  shape: BoxShape.circle,
                  border: active
                      ? Border.all(
                          color: const Color(0xFFE8470A), width: 2)
                      : null,
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: done ? Colors.white : const Color(0xFF8A7570),
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: done
                        ? const Color(0xFFE8470A).withOpacity(0.3)
                        : const Color(0xFFF5EDE8),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        step['label'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: done
                              ? const Color(0xFF1A0F0A)
                              : const Color(0xFF8A7570),
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        step['time'],
                        style: TextStyle(
                          fontSize: 11,
                          color: done
                              ? const Color(0xFFE8470A)
                              : const Color(0xFF8A7570),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step['desc'],
                    style: const TextStyle(
                      color: Color(0xFF8A7570),
                      fontSize: 12,
                    ),
                  ),
                  if (active) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '● In progress',
                        style: TextStyle(
                          color: Color(0xFFE8470A),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
