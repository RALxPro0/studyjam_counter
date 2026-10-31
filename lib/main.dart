import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyJam Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4285F4)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'StudyJam Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _nama = 'Reza Abdul Latif';
  static const String _difabel = 'Mahasiswa Disabilitas Tuli';
  static const String _nim = '255150719111001';
  static const int _target = 25;

  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  Color get _statusColor {
    if (_counter == 0) return const Color(0xFFE53935);
    if (_counter >= _target) return const Color(0xFF2E9E5B);
    return const Color(0xFF1A73E8);
  }

  String get _statusLabel {
    if (_counter == 0) return 'Belum ada yang hadir';
    if (_counter >= _target) return 'Target $_target tercapai!';
    return '${_target - _counter} lagi menuju target';
  }

  IconData get _statusIcon {
    if (_counter == 0) return Icons.hourglass_empty_rounded;
    if (_counter >= _target) return Icons.check_circle_rounded;
    return Icons.trending_up_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Color(0xFF1B2A41),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F0FE), Color(0xFFF6F9FF), Color(0xFFE3F6EC)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProfileCard(),
                    const SizedBox(height: 20),
                    _buildCounterCard(),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reset'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF5F6B7A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.large(
            heroTag: 'decrement',
            onPressed: _decrement,
            tooltip: 'Decrement',
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFE53935),
            elevation: 4,
            child: const Icon(Icons.remove_rounded, size: 40),
          ),
          const SizedBox(width: 28),
          FloatingActionButton.large(
            heroTag: 'increment',
            onPressed: _increment,
            tooltip: 'Increment',
            backgroundColor: const Color(0xFF1A73E8),
            foregroundColor: Colors.white,
            elevation: 4,
            child: const Icon(Icons.add_rounded, size: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/sigma.jpg'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            _nama,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2A41),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            _difabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5F6B7A),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              _nim,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Color(0xFF1A73E8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Text(
            'JUMLAH KEHADIRAN',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFF8A94A6),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Text(
              '$_counter',
              key: ValueKey<int>(_counter),
              style: TextStyle(
                fontSize: 96,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: _statusColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_statusIcon, size: 18, color: _statusColor),
                const SizedBox(width: 6),
                Text(
                  _statusLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _statusColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: (_counter / _target).clamp(0.0, 1.0),
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: const Color(0xFFEDF1F7),
                valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1A73E8).withValues(alpha: 0.10),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
