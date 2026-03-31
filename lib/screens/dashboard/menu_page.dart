import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = 'Breakfast';
  final Map<String, int> _cart = {};

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Breakfast', 'icon': '🌅'},
    {'label': 'Lunch', 'icon': '🍱'},
    {'label': 'Snacks', 'icon': '🥪'},
    {'label': 'Beverages', 'icon': '🧃'},
    {'label': 'Juices', 'icon': '🍹'},
    {'label': 'Packaged', 'icon': '📦'},
  ];

  final Map<String, List<Map<String, dynamic>>> _menuData = {
    'Breakfast': [
      {'name': 'Masala Dosa', 'price': 45, 'emoji': '🫓', 'desc': 'Crispy dosa with spiced potato filling', 'veg': true, 'rating': 4.8},
      {'name': 'Plain Idli (3pc)', 'price': 30, 'emoji': '🍥', 'desc': 'Soft steamed rice cakes with sambar', 'veg': true, 'rating': 4.5},
      {'name': 'Medu Vada (2pc)', 'price': 25, 'emoji': '🍩', 'desc': 'Crispy lentil fritters with coconut chutney', 'veg': true, 'rating': 4.6},
      {'name': 'Poha', 'price': 25, 'emoji': '🍚', 'desc': 'Flattened rice with veggies and peanuts', 'veg': true, 'rating': 4.4},
      {'name': 'Upma', 'price': 20, 'emoji': '🥣', 'desc': 'Semolina cooked with vegetables', 'veg': true, 'rating': 4.2},
      {'name': 'Bread Omelette', 'price': 35, 'emoji': '🍳', 'desc': 'Fluffy omelette served with toast', 'veg': false, 'rating': 4.7},
      {'name': 'Puri Bhaji', 'price': 40, 'emoji': '🫔', 'desc': 'Deep-fried bread with potato curry', 'veg': true, 'rating': 4.5},
      {'name': 'Uttapam', 'price': 40, 'emoji': '🥞', 'desc': 'Thick rice pancake with onion & tomato', 'veg': true, 'rating': 4.3},
    ],
    'Lunch': [
      {'name': 'Veg Thali', 'price': 80, 'emoji': '🍱', 'desc': 'Complete meal with dal, sabzi, rice & roti', 'veg': true, 'rating': 4.9},
      {'name': 'Paneer Butter Masala', 'price': 90, 'emoji': '🍛', 'desc': 'Rich creamy paneer curry with naan', 'veg': true, 'rating': 4.8},
      {'name': 'Veg Biryani', 'price': 90, 'emoji': '🍚', 'desc': 'Fragrant basmati rice with mixed veggies', 'veg': true, 'rating': 4.7},
      {'name': 'Paneer Wrap', 'price': 60, 'emoji': '🌯', 'desc': 'Grilled paneer with mint chutney in wrap', 'veg': true, 'rating': 4.8},
      {'name': 'Dal Fry + Rice', 'price': 55, 'emoji': '🫕', 'desc': 'Classic yellow dal tadka with steamed rice', 'veg': true, 'rating': 4.5},
      {'name': 'Chole Bhature', 'price': 70, 'emoji': '🥘', 'desc': 'Spiced chickpeas with fluffy bhature', 'veg': true, 'rating': 4.6},
      {'name': 'Rajma Chawal', 'price': 65, 'emoji': '🍲', 'desc': 'Kidney bean curry over steamed rice', 'veg': true, 'rating': 4.4},
      {'name': 'Egg Biryani', 'price': 85, 'emoji': '🍳', 'desc': 'Aromatic biryani with boiled eggs', 'veg': false, 'rating': 4.6},
    ],
    'Snacks': [
      {'name': 'Samosa (2pc)', 'price': 20, 'emoji': '🥟', 'desc': 'Crispy fried pastry with spiced potato', 'veg': true, 'rating': 4.8},
      {'name': 'Bread Sandwich', 'price': 30, 'emoji': '🥪', 'desc': 'Grilled sandwich with veggies & cheese', 'veg': true, 'rating': 4.5},
      {'name': 'French Fries', 'price': 35, 'emoji': '🍟', 'desc': 'Golden crispy fries with ketchup', 'veg': true, 'rating': 4.7},
      {'name': 'Pav Bhaji', 'price': 50, 'emoji': '🍞', 'desc': 'Buttery pav with spiced bhaji', 'veg': true, 'rating': 4.9},
      {'name': 'Vada Pav', 'price': 15, 'emoji': '🍔', 'desc': 'Mumbai style street snack', 'veg': true, 'rating': 4.8},
      {'name': 'Spring Rolls (4pc)', 'price': 40, 'emoji': '🥚', 'desc': 'Crispy rolls with vegetable filling', 'veg': true, 'rating': 4.4},
      {'name': 'Nachos & Salsa', 'price': 45, 'emoji': '🌮', 'desc': 'Corn chips with spicy tomato dip', 'veg': true, 'rating': 4.3},
      {'name': 'Bhel Puri', 'price': 25, 'emoji': '🍿', 'desc': 'Puffed rice with chutneys & veggies', 'veg': true, 'rating': 4.6},
    ],
    'Beverages': [
      {'name': 'Coca-Cola 330ml', 'price': 30, 'emoji': '🥤', 'desc': 'Chilled classic cola', 'veg': true, 'rating': 4.5},
      {'name': 'Thums Up 330ml', 'price': 30, 'emoji': '🥤', 'desc': 'Strong cola with bold taste', 'veg': true, 'rating': 4.6},
      {'name': 'Mirinda 330ml', 'price': 28, 'emoji': '🧡', 'desc': 'Orange flavoured fizzy drink', 'veg': true, 'rating': 4.3},
      {'name': 'Sprite 330ml', 'price': 28, 'emoji': '💚', 'desc': 'Lemon-lime refreshing soda', 'veg': true, 'rating': 4.4},
      {'name': 'Cold Coffee', 'price': 35, 'emoji': '☕', 'desc': 'Chilled blended coffee with milk', 'veg': true, 'rating': 4.8},
      {'name': 'Masala Chai', 'price': 15, 'emoji': '🍵', 'desc': 'Spiced Indian milk tea', 'veg': true, 'rating': 4.9},
      {'name': 'Lemon Soda', 'price': 20, 'emoji': '🍋', 'desc': 'Fresh lemon with soda water', 'veg': true, 'rating': 4.7},
      {'name': 'Mango Lassi', 'price': 40, 'emoji': '🥭', 'desc': 'Thick yoghurt mango drink', 'veg': true, 'rating': 4.8},
    ],
    'Juices': [
      {'name': 'Fresh Orange Juice', 'price': 40, 'emoji': '🍊', 'desc': 'Freshly squeezed orange juice', 'veg': true, 'rating': 4.8},
      {'name': 'Watermelon Juice', 'price': 35, 'emoji': '🍉', 'desc': 'Cool refreshing watermelon blend', 'veg': true, 'rating': 4.7},
      {'name': 'Apple Juice', 'price': 35, 'emoji': '🍎', 'desc': 'Sweet chilled apple juice', 'veg': true, 'rating': 4.5},
      {'name': 'Pomegranate Juice', 'price': 50, 'emoji': '🍒', 'desc': 'Rich antioxidant-packed juice', 'veg': true, 'rating': 4.6},
      {'name': 'Sugarcane Juice', 'price': 25, 'emoji': '🌿', 'desc': 'Fresh sugarcane with ginger', 'veg': true, 'rating': 4.9},
      {'name': 'Mixed Fruit Juice', 'price': 45, 'emoji': '🍓', 'desc': 'Seasonal fruit blend', 'veg': true, 'rating': 4.7},
      {'name': 'Pineapple Juice', 'price': 40, 'emoji': '🍍', 'desc': 'Tropical chilled pineapple', 'veg': true, 'rating': 4.4},
      {'name': 'Coconut Water', 'price': 30, 'emoji': '🥥', 'desc': 'Natural tender coconut water', 'veg': true, 'rating': 4.8},
    ],
    'Packaged': [
      {'name': 'Lays Classic 26g', 'price': 20, 'emoji': '🥔', 'desc': 'Salted potato chips', 'veg': true, 'rating': 4.4},
      {'name': 'Kurkure Masala', 'price': 20, 'emoji': '🌽', 'desc': 'Puffed corn snack', 'veg': true, 'rating': 4.6},
      {'name': 'Biscuits (Bourbon)', 'price': 15, 'emoji': '🍪', 'desc': 'Chocolate cream biscuits', 'veg': true, 'rating': 4.5},
      {'name': 'Dairy Milk 42g', 'price': 40, 'emoji': '🍫', 'desc': 'Smooth milk chocolate', 'veg': true, 'rating': 4.8},
      {'name': 'Maggi 2-min Noodles', 'price': 30, 'emoji': '🍜', 'desc': 'Classic instant noodles', 'veg': true, 'rating': 4.7},
      {'name': 'Red Bull 250ml', 'price': 110, 'emoji': '⚡', 'desc': 'Energy drink with caffeine', 'veg': true, 'rating': 4.3},
      {'name': 'Kit Kat 37g', 'price': 35, 'emoji': '🍫', 'desc': 'Crispy wafer chocolate bar', 'veg': true, 'rating': 4.6},
      {'name': 'Parle-G 100g', 'price': 10, 'emoji': '🫙', 'desc': 'Classic glucose biscuits', 'veg': true, 'rating': 4.5},
    ],
  };

  int get _cartCount => _cart.values.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final items = _menuData[_selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        title: const Text('Menu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              if (_cartCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$_cartCount',
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFFE8470A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search food items…',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE8470A)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Category chips horizontal scroll
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = _selectedCategory == cat['label'];
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedCategory = cat['label']!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          selected ? const Color(0xFFE8470A) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? const Color(0xFFE8470A).withOpacity(0.3)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cat['icon']!,
                            style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 4),
                        Text(
                          cat['label']!,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : const Color(0xFF8A7570),
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Item count label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '$_selectedCategory  •  ${items.length} items',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1A0F0A),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Items list
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) => _menuCard(items[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(Map<String, dynamic> item) {
    final count = _cart[item['name']] ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: Center(
                  child: Text(item['emoji'],
                      style: const TextStyle(fontSize: 48)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: item['veg'] as bool
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: item['veg'] as bool
                          ? Colors.green
                          : Colors.red,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: item['veg'] as bool ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF1A0F0A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['desc'],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8A7570),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '₹${item['price']}',
                        style: const TextStyle(
                          color: Color(0xFFE8470A),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFB300), size: 12),
                      Text(
                        ' ${item['rating']}',
                        style: const TextStyle(
                            fontSize: 10, color: Color(0xFF8A7570)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  count == 0
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                setState(() => _cart[item['name']] = 1),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              textStyle: const TextStyle(fontSize: 11),
                            ),
                            child: const Text('Add'),
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
                                  _cart[item['name']] = count - 1;
                                }
                              });
                            }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('$count',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            _qtyBtn(Icons.add, () {
                              setState(() => _cart[item['name']] = count + 1);
                            }),
                          ],
                        ),
                ],
              ),
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
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }
}
