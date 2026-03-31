import 'package:flutter/material.dart';
import 'signup_page.dart';
import '../dashboard/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      body: Row(
        children: [
          // ── Left decorative panel (visible on wide screens) ──────────────
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              flex: 5,
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
                    // Background circles
                    Positioned(
                      top: -60,
                      left: -60,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      right: -40,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),
                    // Content
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo
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
                            const SizedBox(height: 36),
                            const Text(
                              'BENTO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 6,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Smart Canteen\nManagement System',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 48),
                            _featureChip(Icons.flash_on, 'Order in seconds'),
                            const SizedBox(height: 16),
                            _featureChip(Icons.track_changes, 'Real-time tracking'),
                            const SizedBox(height: 16),
                            _featureChip(Icons.event_seat, 'Seat availability'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Right: login form ─────────────────────────────────────────────
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Mobile logo
                      if (MediaQuery.of(context).size.width <= 800) ...[
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8470A),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.restaurant_menu,
                                    color: Colors.white, size: 24),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'BENTO',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFE8470A),
                                  letterSpacing: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],

                      const Text(
                        'Welcome back 👋',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0F0A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Sign in to your canteen account',
                        style: TextStyle(color: Color(0xFF8A7570), fontSize: 15),
                      ),
                      const SizedBox(height: 36),

                      // Google sign-in
                      _googleButton(context),
                      const SizedBox(height: 20),

                      // Divider
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0xFFE0D5CF))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'or sign in with email',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0xFFE0D5CF))),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Email
                      TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Color(0xFFE8470A)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextField(
                        controller: _passCtrl,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color(0xFFE8470A)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF8A7570),
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Color(0xFFE8470A)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DashboardPage(
                                    userName: 'Anushree'),
                              ),
                            );
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Sign up link
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Color(0xFF8A7570)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignupPage()),
                                );
                              },
                              child: const Text(
                                'Create account',
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

  Widget _googleButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const DashboardPage(userName: 'Anushree'),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: Color(0xFFE0D5CF), width: 1.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Google G icon (drawn with text)
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8470A),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Continue with Google',
            style: TextStyle(
              color: Color(0xFF1A0F0A),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureChip(IconData icon, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
