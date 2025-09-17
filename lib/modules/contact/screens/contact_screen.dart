import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/modules/contact/controller/contact_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: isMobile ? 24 : 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText('Contact Me', fontSize: isMobile ? 36 : 48),
                    SizedBox(height: isMobile ? 12 : 16),
                    Text(
                      'Get in touch to discuss your project or idea!',
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    _buildPanel(
                      Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              controller.nameController,
                              'Name',
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Please enter your name' : null,
                              isMobile: isMobile,
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            _buildTextField(
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
                              isMobile: isMobile,
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            _buildTextField(
                              controller.messageController,
                              'Message',
                              maxLines: isMobile ? 4 : 5,
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Please enter your message' : null,
                              isMobile: isMobile,
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            Center(
                              child: _buildButton(
                                'Send Message',
                                onPressed: () {
                                  if (controller.formKey.currentState!.validate()) {
                                    controller.submitForm();
                                  }
                                },
                                isMobile: isMobile,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isMobile: isMobile,
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    _buildText('Connect with Me', fontSize: isMobile ? 20 : 24),
                    SizedBox(height: isMobile ? 8 : 12),
                    Wrap(
                      spacing: isMobile ? 6 : 8,
                      runSpacing: isMobile ? 6 : 8,
                      children: [
                        _buildSocialButton(
                          icon: Icons.code,
                          label: 'GitHub',
                          url: 'https://github.com/yourusername',
                          isMobile: isMobile,
                        ),
                        _buildSocialButton(
                          icon: Icons.link,
                          label: 'LinkedIn',
                          url: 'https://linkedin.com/in/yourusername',
                          isMobile: isMobile,
                        ),
                        _buildSocialButton(
                          icon: Icons.email,
                          label: 'Email',
                          url: 'mailto:your.email@example.com',
                          isMobile: isMobile,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildText(String text, {required double fontSize}) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isHovering ? Colors.white : Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildPanel(Widget child, {required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    String? Function(String?)? validator,
    int maxLines = 1,
    required bool isMobile,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: GoogleFonts.montserrat(
        fontSize: isMobile ? 13 : 15,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(
          fontSize: isMobile ? 13 : 15,
          color: Colors.white.withOpacity(0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFD700)),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildButton(String text, {required VoidCallback onPressed, required bool isMobile}) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Material(
        color: isHovering ? const Color(0xFF1E1E1E) : const Color(0xFF121212),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 10 : 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w600,
                color: isHovering ? const Color(0xFFFFD700) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
    required bool isMobile,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => GestureDetector(
        onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            border: Border.all(
              color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: isMobile ? 16 : 18, color: Colors.white),
              SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
