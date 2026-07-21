import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/components/default_button.dart';
import 'package:web_app/components/section_title.dart';
import 'package:web_app/constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // this height only for demo
      // height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFE8F0F9),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg_img_2.png"),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding * 2.5),
          SectionTitle(
            title: "Contact Me",
            subTitle: "For Project inquiry and information",
            color: kAccentColor,
          ),
          ContactBox()
        ],
      ),
    );
  }
}

class ContactBox extends StatelessWidget {
  const ContactBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      constraints: BoxConstraints(maxWidth: 1110),
      margin: EdgeInsets.only(top: kDefaultPadding * 2),
      padding: EdgeInsets.all(isMobile ? kDefaultPadding : kDefaultPadding * 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          ContactForm(),
        ],
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  static const _formspreeId = 'mwvgblaq';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackbar('Please fix the errors before submitting.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/$_formspreeId'),
        headers: {'Accept': 'application/json'},
        body: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'message': _messageController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        _showSuccessDialog();
      } else {
        _showSnackbar('Failed to send. Please try again.');
      }
    } catch (_) {
      _showSnackbar('Network error. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: kAccentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: kAccentColor, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                "Message Sent!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Thanks for reaching out. I'll get back to you as soon as possible.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kTextColor, height: 1.5),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Done", style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final fieldWidth = isMobile ? double.infinity : 470.0;

    return Form(
      key: _formKey,
      child: Wrap(
        spacing: kDefaultPadding * 2.5,
        runSpacing: kDefaultPadding * 1.5,
        children: [
          SizedBox(
            width: fieldWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Name", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),
              ],
            ),
          ),
          SizedBox(
            width: fieldWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email Address", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email address",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    final emailRegex = RegExp(r'^[\w\.\+\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  controller: _messageController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Write some description",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Message is required' : null,
                ),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding * 2),
          Center(
            child: FittedBox(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : DefaultButton(
                      imageSrc: "assets/images/contact_icon.png",
                      text: "Contact Me!",
                      press: _submit,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
