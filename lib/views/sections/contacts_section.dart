import 'package:flutter/material.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';

class ContactsSection extends StatelessWidget {
  const ContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('#contacts', style: TextStyle(fontSize: 24, color: Colors.purple)),
        const Text('Contact info here...'), // Add links, form if needed (use StatefulWidget for form)
        CustomButton(text: 'Message me here', onPressed: () {}),
      ],
    );
  }
}