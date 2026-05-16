import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstCtrl  = TextEditingController();
  final _lastCtrl   = TextEditingController();
  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _hidePass    = true;
  bool _hideConfirm = true;
  bool _agreed      = false;
  bool _loading     = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the Terms of Service.', style: GoogleFonts.dmSans()),
          backgroundColor: const Color(0xFFE05A7A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _loading = false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFEEF0F6), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 8),

                    // ── HEADER ───────────────────────────────────
                    Text('Create your\naccount.', style: GoogleFonts.syne(fontSize: 38, fontWeight: FontWeight.w800, color: const Color(0xFFEEF0F6), height: 1.08, letterSpacing: -1.5)),
                    const SizedBox(height: 10),
                    Text('First hour free. No subscription needed.', style: GoogleFonts.dmSans(fontSize: 14, color: const Color(0xFF6A7090), fontWeight: FontWeight.w300)),

                    const SizedBox(height: 36),

                    // ── FIRST + LAST NAME ────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _FieldLabel('First Name'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _firstCtrl,
                                textCapitalization: TextCapitalization.words,
                                style: _inputTextStyle,
                                decoration: _inputDeco(hint: 'Ahmed'),
                                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _FieldLabel('Last Name'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _lastCtrl,
                                textCapitalization: TextCapitalization.words,
                                style: _inputTextStyle,
                                decoration: _inputDeco(hint: 'Mohamed'),
                                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── EMAIL ────────────────────────────────────
                    const _FieldLabel('Email address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      style: _inputTextStyle,
                      decoration: _inputDeco(
                        hint: 'you@example.com',
                        prefix: const Icon(Icons.mail_outline_rounded, color: Color(0xFF6A7090), size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // ── PASSWORD ─────────────────────────────────
                    const _FieldLabel('Password'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _hidePass,
                      style: _inputTextStyle,
                      decoration: _inputDeco(
                        hint: 'Min. 8 characters',
                        prefix: const Icon(Icons.lock_outline_rounded, color: Color(0xFF6A7090), size: 20),
                        suffix: GestureDetector(
                          onTap: () => setState(() => _hidePass = !_hidePass),
                          child: Icon(_hidePass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7090), size: 20),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password is required';
                        if (v.length < 8) return 'Minimum 8 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // ── CONFIRM PASSWORD ─────────────────────────
                    const _FieldLabel('Confirm Password'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: _hideConfirm,
                      style: _inputTextStyle,
                      decoration: _inputDeco(
                        hint: 'Re-enter your password',
                        prefix: const Icon(Icons.lock_outline_rounded, color: Color(0xFF6A7090), size: 20),
                        suffix: GestureDetector(
                          onTap: () => setState(() => _hideConfirm = !_hideConfirm),
                          child: Icon(_hideConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7090), size: 20),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please confirm your password';
                        if (v != _passCtrl.text) return 'Passwords do not match';
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    // ── TERMS CHECKBOX ───────────────────────────
                    GestureDetector(
                      onTap: () => setState(() => _agreed = !_agreed),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 22, height: 22,
                            margin: const EdgeInsets.only(top: 1),
                            decoration: BoxDecoration(
                              color: _agreed ? const Color(0xFFF5A623) : Colors.transparent,
                              border: Border.all(
                                color: _agreed ? const Color(0xFFF5A623) : const Color(0x1FFFFFFF),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: _agreed
                                ? const Icon(Icons.check_rounded, color: Color(0xFF080B12), size: 14)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: 'I agree to the ', style: GoogleFonts.dmSans(color: const Color(0xFF6A7090), fontSize: 13)),
                                TextSpan(text: 'Terms of Service', style: GoogleFonts.dmSans(color: const Color(0xFFF5A623), fontSize: 13, fontWeight: FontWeight.w500)),
                                TextSpan(text: ' and ', style: GoogleFonts.dmSans(color: const Color(0xFF6A7090), fontSize: 13)),
                                TextSpan(text: 'Privacy Policy', style: GoogleFonts.dmSans(color: const Color(0xFFF5A623), fontSize: 13, fontWeight: FontWeight.w500)),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── CREATE ACCOUNT BUTTON ────────────────────
                    GestureDetector(
                      onTap: _loading ? null : _register,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: _agreed
                              ? const LinearGradient(colors: [Color(0xFFF5A623), Color(0xFFE8920A)])
                              : null,
                          color: _agreed ? null : const Color(0xFF111624),
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: _agreed
                              ? [BoxShadow(color: const Color(0xFFF5A623).withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 8))]
                              : [],
                        ),
                        child: Center(
                          child: _loading
                              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Color(0xFF080B12), strokeWidth: 2.5))
                              : Text(
                                  'Create Account',
                                  style: GoogleFonts.syne(fontSize: 15, fontWeight: FontWeight.w700, color: _agreed ? const Color(0xFF080B12) : const Color(0xFF6A7090)),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── SIGN IN LINK ─────────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'Already have an account?  ', style: GoogleFonts.dmSans(color: const Color(0xFF6A7090), fontSize: 14)),
                            TextSpan(text: 'Sign in', style: GoogleFonts.dmSans(color: const Color(0xFFF5A623), fontSize: 14, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get _inputTextStyle => GoogleFonts.dmSans(color: const Color(0xFFEEF0F6), fontSize: 15);

  InputDecoration _inputDeco({required String hint, Widget? prefix, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefix != null ? Padding(padding: const EdgeInsets.only(left: 4), child: prefix) : null,
      suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.only(right: 4), child: suffix) : null,
    );
  }
}

// ── FIELD LABEL ───────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.syne(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFFEEF0F6), letterSpacing: 0.3),
    );
  }
}
