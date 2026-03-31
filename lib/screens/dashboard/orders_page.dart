import 'package:flutter/material.dart';
import 'tracking_page.dart';

class OrdersPage extends StatefulWidget {
  final Map<String, int> cart;
  final List<Map<String, dynamic>> items;

  const OrdersPage({super.key, required this.cart, required this.items});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Map<String, int> _cart;
  bool _orderPlaced = false;

  @override
  void initState() {
    super.initState();
    _cart = Map.from(widget.cart);
    // Add demo items if cart is empty
    if (_cart.isEmpty) {
      _cart = {
        'Masala Dosa': 1,
        'Samosa (2pc)': 2,
        'Cold Coffee': 1,
      };
    }
  }

  int get _subtotal {
    int total = 0;
    _cart.forEach((name, qty) {
      final item = widget.items.firstWhere(
        (i) => i['name'] == name,
        orElse: () => {'price': _fallbackPrice(name)},
      );
      total += (item['price'] as int) * qty;
    });
    return total;
  }

  int _fallbackPrice(String name) {
    const prices = {
      'Masala Dosa': 45,
      'Samosa (2pc)': 20,
      'Cold Coffee': 35,
      'Veg Thali': 80,
    };
    return prices[name] ?? 0;
  }

  int get _gst => (_subtotal * 0.05).round();
  int get _total => _subtotal + _gst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _orderPlaced ? _orderPlacedView() : _cartView(),
    );
  }

  Widget _cartView() {
    if (_cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🛒', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0F0A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add items from the menu',
              style: TextStyle(color: Color(0xFF8A7570)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Browse Menu'),
            ),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cart items
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    const Text(
                      'Cart Items',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A0F0A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8470A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_cart.length} items',
                        style: const TextStyle(
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
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: _cart.entries.map((e) {
                    final name = e.key;
                    final qty = e.value;
                    final price = _fallbackPriceForItem(name);
                    return _cartItem(name, qty, price);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Order summary
        Container(
          width: 340,
          margin: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Delivery options
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
                      'Pickup Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A0F0A),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _pickupOption('🏃', 'Express Counter', '5-8 min', true),
                    const SizedBox(height: 10),
                    _pickupOption('🕐', 'Scheduled', 'Choose time', false),
                    const SizedBox(height: 14),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Color(0xFFE8470A), size: 18),
                        const SizedBox(width: 6),
                        const Text(
                          'Main Canteen, Ground Floor',
                          style: TextStyle(
                            color: Color(0xFF8A7570),
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              color: Color(0xFFE8470A),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bill summary
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
                      'Order Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A0F0A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _billRow('Subtotal', '₹$_subtotal'),
                    const SizedBox(height: 8),
                    _billRow('GST (5%)', '₹$_gst'),
                    const SizedBox(height: 8),
                    _billRow('Canteen Discount', '-₹0',
                        color: Colors.green),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(),
                    ),
                    _billRow('Total', '₹$_total', bold: true),
                    const SizedBox(height: 20),

                    // Place order button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _orderPlaced = true);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 18),
                            const SizedBox(width: 8),
                            Text('Place Order  •  ₹$_total'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cartItem(String name, int qty, int price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('🍽️', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A0F0A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹$price each',
                  style: const TextStyle(
                    color: Color(0xFF8A7570),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _smallQtyBtn(Icons.remove, () {
                setState(() {
                  if (qty == 1) {
                    _cart.remove(name);
                  } else {
                    _cart[name] = qty - 1;
                  }
                });
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$qty',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              _smallQtyBtn(Icons.add, () {
                setState(() => _cart[name] = qty + 1);
              }),
            ],
          ),
          const SizedBox(width: 16),
          Text(
            '₹${price * qty}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE8470A),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: const Color(0xFFE8470A).withOpacity(0.3)),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFFE8470A)),
      ),
    );
  }

  Widget _pickupOption(
      String emoji, String title, String sub, bool selected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            selected ? const Color(0xFFFFF3E0) : const Color(0xFFF5EDE8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? const Color(0xFFE8470A)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1A0F0A),
                  )),
              Text(sub,
                  style: const TextStyle(
                    color: Color(0xFF8A7570),
                    fontSize: 11,
                  )),
            ],
          ),
          const Spacer(),
          if (selected)
            const Icon(Icons.check_circle_rounded,
                color: Color(0xFFE8470A), size: 18),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value,
      {bool bold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF8A7570),
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: bold ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? (bold ? const Color(0xFF1A0F0A) : const Color(0xFF8A7570)),
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: bold ? 18 : 14,
          ),
        ),
      ],
    );
  }

  Widget _orderPlacedView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('✅', style: TextStyle(fontSize: 48)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Order Placed!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A0F0A),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your order has been confirmed.\nEstimated time: ~12 minutes',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF8A7570), fontSize: 15),
          ),
          const SizedBox(height: 8),
          Text(
            'Order Total: ₹$_total',
            style: const TextStyle(
              color: Color(0xFFE8470A),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TrackingPage()));
            },
            icon: const Icon(Icons.location_on),
            label: const Text('Track My Order'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Back to Dashboard',
              style: TextStyle(color: Color(0xFF8A7570)),
            ),
          ),
        ],
      ),
    );
  }

  int _fallbackPriceForItem(String name) {
    final found = widget.items.firstWhere(
      (i) => i['name'] == name,
      orElse: () => {'price': _fallbackPrice(name)},
    );
    return found['price'] as int;
  }
}
