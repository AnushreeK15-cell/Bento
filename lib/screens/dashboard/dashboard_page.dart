import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'orders_page.dart';
import 'tracking_page.dart';
import 'history_page.dart';
import 'seat_page.dart';
import '../auth/login_page.dart';

class DashboardPage extends StatefulWidget {
  final String userName;
  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _sidebarCollapsed = false;

  // Quick cart state
  final Map<String, int> _cart = {};

  final List<Map<String, dynamic>> _featuredItems = [
  {
    'name': 'Masala Dosa',
    'price': 45,
    'tag': 'Breakfast',
    'image': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0',
    'rating': 4.8,
    'color': const Color(0xFFFFF3E0),
  },
  {
    'name': 'Veg Thali',
    'price': 80,
    'tag': 'Lunch',
    'image': 'https://images.unsplash.com/photo-1604909052743-94e838986d24',
    'rating': 4.6,
    'color': const Color(0xFFE8F5E9),
  },
  {
    'name': 'Samosa (2pc)',
    'price': 20,
    'tag': 'Snacks',
    'image': 'https://images.unsplash.com/photo-1617196038435-4f9c0f6b9c91',
    'rating': 4.7,
    'color': const Color(0xFFFCE4EC),
  },
  {
    'name': 'Cold Coffee',
    'price': 35,
    'tag': 'Beverage',
    'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
    'rating': 4.5,
    'color': const Color(0xFFE3F2FD),
  },
  {
    'name': 'Poha',
    'price': 25,
    'tag': 'Breakfast',
    'image': 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f',
    'rating': 4.4,
    'color': const Color(0xFFF3E5F5),
  },
  {
    'name': 'Paneer Wrap',
    'price': 60,
    'tag': 'Lunch',
    'image': 'https://images.unsplash.com/photo-1601050690597-df0568f70950',
    'rating': 4.9,
    'color': const Color(0xFFE8F5E9),
  },
  {
    'name': 'Lemon Soda',
    'price': 20,
    'tag': 'Beverage',
    'image': 'https://images.unsplash.com/photo-1551024601-bec78aea704b',
    'rating': 4.3,
    'color': const Color(0xFFFFF9C4),
  },
  {
    'name': 'Veg Biryani',
    'price': 90,
    'tag': 'Lunch',
    'image': 'https://images.unsplash.com/photo-1563379091339-03246963d96c',
    'rating': 4.8,
    'color': const Color(0xFFFFF3E0),
  },
];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.grid_view_rounded, 'label': 'Dashboard'},
    {'icon': Icons.restaurant_menu_rounded, 'label': 'Menu'},
    {'icon': Icons.shopping_bag_rounded, 'label': 'My Orders'},
    {'icon': Icons.location_on_rounded, 'label': 'Tracking'},
    {'icon': Icons.history_rounded, 'label': 'History'},
    {'icon': Icons.event_seat_rounded, 'label': 'Seats'},
  ];

  int get _cartCount => _cart.values.fold(0, (a, b) => a + b);
  int get _cartTotal =>
      _cart.entries.fold(0, (a, e) {
        final item = _featuredItems.firstWhere(
            (i) => i['name'] == e.key,
            orElse: () => {'price': 0});
        return a + (item['price'] as int) * e.value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE8),
      body: Row(
        children: [
          // ── Sidebar ────────────────────────────────────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOut,
            width: _sidebarCollapsed ? 72 : 240,
            decoration: const BoxDecoration(
              color: Color(0xFF1A0F0A),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 28),

                // Logo row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8470A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.restaurant_menu,
                            color: Colors.white, size: 20),
                      ),
                      if (!_sidebarCollapsed) ...[
                        const SizedBox(width: 10),
                        const Text(
                          'BENTO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _sidebarCollapsed = true),
                          child: const Icon(Icons.chevron_left,
                              color: Color(0xFF8A7570)),
                        ),
                      ] else
                        GestureDetector(
                          onTap: () =>
                              setState(() => _sidebarCollapsed = false),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(Icons.chevron_right,
                                color: Color(0xFF8A7570)),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // User card
                if (!_sidebarCollapsed)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFFE8470A),
                          child: Text(
                            widget.userName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'Student',
                              style: TextStyle(
                                color: Color(0xFF8A7570),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Nav items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _navItems.length,
                    itemBuilder: (_, i) {
                      final selected = _selectedIndex == i;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          leading: Icon(
                            _navItems[i]['icon'],
                            color: selected
                                ? Colors.white
                                : const Color(0xFF8A7570),
                            size: 22,
                          ),
                          title: _sidebarCollapsed
                              ? null
                              : Text(
                                  _navItems[i]['label'],
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xFF8A7570),
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                          selected: selected,
                          selectedTileColor: const Color(0xFFE8470A),
                          tileColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onTap: () {
                            if (i == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MenuPage()));
                            } else if (i == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OrdersPage(
                                          cart: _cart,
                                          items: _featuredItems)));
                            } else if (i == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TrackingPage()));
                            } else if (i == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HistoryPage()));
                            } else if (i == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SeatPage()));
                            } else {
                              setState(() => _selectedIndex = i);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Sign out
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ListTile(
                    leading: const Icon(Icons.logout_rounded,
                        color: Color(0xFFE8470A), size: 22),
                    title: _sidebarCollapsed
                        ? null
                        : const Text('Sign Out',
                            style: TextStyle(
                                color: Color(0xFFE8470A), fontSize: 14)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginPage())),
                  ),
                ),
              ],
            ),
          ),

          // ── Main content ───────────────────────────────────────────────────
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.fromLTRB(28, 20, 28, 20),
                  color: const Color(0xFFFFF8F4),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, ${widget.userName} 👋',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A0F0A),
                            ),
                          ),
                          const Text(
                            'What would you like to eat today?',
                            style: TextStyle(
                                color: Color(0xFF8A7570), fontSize: 14),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Cart button
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => OrdersPage(
                                    cart: _cart, items: _featuredItems))),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8470A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.shopping_bag_rounded,
                                  color: Colors.white, size: 22),
                            ),
                            if (_cartCount > 0)
                              Positioned(
                                top: -6,
                                right: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$_cartCount',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFE8470A),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats row
                        Row(
                          children: [
                            _statCard('🍽️', 'Today\'s Orders', '3',
                                const Color(0xFFFFF3E0)),
                            const SizedBox(width: 16),
                            _statCard('💰', 'Amount Spent', '₹145',
                                const Color(0xFFE8F5E9)),
                            const SizedBox(width: 16),
                            _statCard('⏱️', 'Avg Wait Time', '8 min',
                                const Color(0xFFE3F2FD)),
                            const SizedBox(width: 16),
                            _statCard('🪑', 'Seats Free', '42',
                                const Color(0xFFFCE4EC)),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Live order tracker (shows when cart has items)
                        if (_cartCount > 0) ...[
                          _liveTracker(),
                          const SizedBox(height: 28),
                        ],

                        // Section header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today\'s Featured',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A0F0A),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MenuPage())),
                              child: const Text(
                                'See full menu →',
                                style: TextStyle(color: Color(0xFFE8470A)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Food grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.78,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: _featuredItems.length,
                          itemBuilder: (_, i) => _foodCard(_featuredItems[i]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String emoji, String label, String value, Color bg) {
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
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0F0A),
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

  Widget _liveTracker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8470A), Color(0xFFFF7043)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🔥 Order in Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your order is being prepared',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Text(
                '~12 min',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              _progressStep(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressStep() {
    const steps = ['Placed', 'Accepted', 'Preparing', 'Ready'];
    return Row(
      children: steps.asMap().entries.map((e) {
        final done = e.key <= 1;
        return Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? Colors.white : Colors.white38,
              ),
            ),
            if (e.key < steps.length - 1)
              Container(
                  width: 20, height: 2, color: done ? Colors.white : Colors.white24),
          ],
        );
      }).toList(),
    );
  }

  Widget _foodCard(Map<String, dynamic> item) {
    final count = _cart[item['name']] ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: item['color'] as Color,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                item['emoji'] as String,
                style: const TextStyle(fontSize: 52),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item['tag'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFE8470A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1A0F0A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFB300), size: 14),
                    const SizedBox(width: 2),
                    Text(
                      '${item['rating']}',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF8A7570)),
                    ),
                    const Spacer(),
                    Text(
                      '₹${item['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE8470A),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Add to cart
                count == 0
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() =>
                                _cart[item['name'] as String] = 1);
                          },
                          style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(vertical: 8),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _qtyBtn(Icons.remove, () {
                            setState(() {
                              if (count == 1) {
                                _cart.remove(item['name']);
                              } else {
                                _cart[item['name'] as String] = count - 1;
                              }
                            });
                          }),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A0F0A),
                              ),
                            ),
                          ),
                          _qtyBtn(Icons.add, () {
                            setState(
                                () => _cart[item['name'] as String] = count + 1);
                          }),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFE8470A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
