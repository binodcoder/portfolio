import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class ContactSection extends StatelessWidget {
  const ContactSection();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: context.space(10)),
        // Professional contact form UI (use full available width)
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 1,
            child: Padding(
              padding: context.insetsAll(16),
              child: const _ContactForm(),
            ),
          ),
        ),
        SizedBox(height: context.space(12)),
      ],
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'This field is required';
    final value = v.trim();
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
    return ok ? null : 'Enter a valid email';
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks! Your message has been noted.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Full name'),
            validator: _required,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.space(10)),
          TextFormField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.space(10)),
          TextFormField(
            controller: _subjectCtrl,
            decoration: const InputDecoration(labelText: 'Subject (optional)'),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.space(10)),
          TextFormField(
            controller: _messageCtrl,
            decoration: const InputDecoration(labelText: 'Message'),
            minLines: 5,
            maxLines: 10,
            validator: _required,
            textInputAction: TextInputAction.newline,
          ),
          SizedBox(height: context.space(12)),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}
