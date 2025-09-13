import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/modules/contact/controller/contact_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BackgroundWidget(
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGlowingText('Contact Me', fontSize: 64),
            const SizedBox(height: 24),
            Text(
              'Get in touch to discuss your project or idea!',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 32),
            _buildGlowingPanel(
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGlowingTextField(
                      controller.nameController,
                      'Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildGlowingTextField(
                      controller.emailController,
                      'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildGlowingTextField(
                      controller.messageController,
                      'Message',
                      maxLines: 5,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter your message' : null,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: _buildGlowingButton(
                        'Send Message',
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.submitForm();
                            _showSuccessMessage(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingText(String text, {
    required double fontSize,
    Color textColor = Colors.white,
    Color glowColor = const Color(0xFF4C00C2),
  }) {
    return Text(
      text,
      style: GoogleFonts.orbitron(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        shadows: [
          Shadow(color: glowColor.withOpacity(0.6), blurRadius: 15),
          Shadow(color: glowColor.withOpacity(0.3), blurRadius: 30),
        ],
      ),
    );
  }

  Widget _buildGlowingButton(String text, {required VoidCallback onPressed}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HoverEffect(
        builder: (isHovering) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovering
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: isHovering
                    ? [const Color(0xFF00C7FF), const Color(0xFF4C00C2)]
                    : [const Color(0xFF4C00C2), const Color(0xFF00C7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C7FF).withOpacity(isHovering ? 0.8 : 0.4),
                  blurRadius: isHovering ? 20 : 10,
                  spreadRadius: isHovering ? 4 : 2,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: const [
                        Shadow(color: Colors.white, blurRadius: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlowingPanel(Widget child) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildGlowingTextField(
    TextEditingController controller,
    String labelText, {
    String? Function(String?)? validator,
    int? maxLines,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4C00C2).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.montserrat(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(color: Colors.white70),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00C7FF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Message sent successfully!',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4C00C2).withOpacity(0.8),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
