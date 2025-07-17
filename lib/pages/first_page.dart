import 'package:flutter/material.dart';
import 'package:intership_suitmedia/pages/second_page.dart';
import 'package:intership_suitmedia/provider/provider.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  bool isPalindrome(String text) {
    // Hapus semua karakter non-alphanumeric dan ubah ke lowercase
    final clean = text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return clean == clean.split('').reversed.join('');
  }

  void _checkPalindrome() {
    // Tutup keyboard
    FocusScope.of(context).unfocus();

    final text = _sentenceController.text.trim();

    // Validasi input kosong
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a sentence to check',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }

    final result = isPalindrome(text);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Result', style: TextStyle(fontFamily: 'Poppins')),
        content: Text(
          result ? 'isPalindrome' : 'not palindrome',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void _goToSecondScreen() {
    // Tutup keyboard
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your name',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }

    Provider.of<AppState>(context, listen: false).setName(name);
    Navigator.push(context, MaterialPageRoute(builder: (_) => SecondScreen()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/Background.png",
            ), // Ganti path sesuai lokasi file kamu
            fit: BoxFit
                .cover, // Sesuaikan dengan kebutuhan (bisa juga BoxFit.fill, BoxFit.contain, dst)
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    // Profile icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_add,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Name TextField
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Palindrome TextField
                    TextField(
                      controller: _sentenceController,
                      decoration: InputDecoration(
                        hintText: 'Palindrome',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),

                    // Spacer untuk menempatkan buttons di tengah
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    // Check Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _checkPalindrome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B637B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'CHECK',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _goToSecondScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B637B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
