import 'package:binodfolio/src/features/home/presentation/widgets/contact/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
              child: const ContactForm(),
            ),
          ),
        ),
        SizedBox(height: context.space(12)),
      ],
    );
  }
}
