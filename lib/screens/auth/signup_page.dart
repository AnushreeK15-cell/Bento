import 'package:flutter/material.dart';
import '../dashboard/dashboard_page.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  String _selectedRole = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      body: Row(
        children: [
          // Left panel
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE8470A), Color(0xFFFF7043)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -60,
                      right: -60,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.restaurant_menu,
                                color: Color(0xFFE8470A),
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'Join\nBENTO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Create your canteen account\nand start ordering.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _stepItem('1', 'Create your account'),
                            const SizedBox(height: 14),
                            _stepItem('2', 'Browse the menu'),
                            const SizedBox(height: 14),
                            _stepItem('3', 'Order & track live'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Right: form
          Expanded(
            flex: 5,
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (MediaQuery.of(context).size.width <= 800) ...[
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'BENTO',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFE8470A),
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0F0A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Fill in your details to get started',
                        style: TextStyle(color: Color(0xFF8A7570), fontSize: 15),
                      ),
                      const SizedBox(height: 32),

                      // Role selector
                      Row(
                        children: ['Student', 'Faculty', 'Staff'].map((role) {
                          final selected = _selectedRole == role;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedRole = role),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFFE8470A)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xFFE8470A)
                                        : const Color(0xFFE0D5CF),
                                  ),
                                ),
                                child: Text(
                                  role,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xFF8A7570),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Full name
                      TextField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline,
                              color: Color(0xFFE8470A)),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Email
                      TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'College Email',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Color(0xFFE8470A)),
                          hintText: 'yourname@college.edu',
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Phone + Roll in a row
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _phoneCtrl,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone_outlined,
                                    color: Color(0xFFE8470A)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _rollCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Roll / ID No.',
                                prefixIcon: Icon(Icons.badge_outlined,
                                    color: Color(0xFFE8470A)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Password
                      TextField(
                        controller: _passCtrl,
                        obscureText: _obscurePass,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFFE8470A)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF8A7570),
                            ),
                            onPressed: () =>
                                setState(() => _obscurePass = !_obscurePass),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Confirm password
                      TextField(
                        controller: _confirmCtrl,
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFFE8470A)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF8A7570),
                            ),
                            onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Register
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DashboardPage(
                                    userName: _nameCtrl.text.isEmpty
                                        ? 'User'
                                        : _nameCtrl.text.split(' ').first),
                              ),
                            );
                          },
                          child: const Text('Create My Account'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: Color(0xFF8A7570)),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(0xFFE8470A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String number, String label) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFFE8470A),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
