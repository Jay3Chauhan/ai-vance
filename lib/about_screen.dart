/*
 * Copyright (C) 2026 Jay Chauhan
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// Comprehensive "About" screen featuring AI Vance overview, local AI architecture,
/// and creator profile with verified links from https://jaychauhan.tech.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static final Uri _website = Uri.parse('https://jaychauhan.tech');
  static final Uri _github = Uri.parse('https://github.com/Jay3Chauhan');
  static final Uri _linkedin = Uri.parse('https://www.linkedin.com/in/jay-chauhan-5a65921ba/');
  static final Uri _twitter = Uri.parse('https://twitter.com/Jay3_Chauhan');
  static final Uri _email = Uri.parse('mailto:contact@jaychauhan.tech');
  static final Uri _privacyPolicy = Uri.parse(
      'https://app.notion.com/p/AI-Vance-3d9a57849d8e80dfa857c6c8b2ad9a91');

  Future<void> _open(BuildContext context, Uri url) async {
    final ok = await launchUrl(url, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open ${url.toString()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFF070A18),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D122B),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'About AI Vance',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          // Logo & App Name Header
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/ai_vance_logo.png',
                  width: 96,
                  height: 96,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 14),
                Text(
                  'AI Vance',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '100% On-Device • Version 1.0.0',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Overview Card
          _buildCard(
            colorScheme: colorScheme,
            title: 'Privacy-First Edge Intelligence',
            subtitle:
                'AI Vance executes advanced quantized neural networks (GGUF) directly on your device CPU/GPU.\n\n'
                '• No subscriptions or cloud tokens required\n'
                '• Zero telemetry or server chat logging\n'
                '• Works completely offline with full privacy\n'
                '• ARM NEON & multi-core hardware acceleration',
            icon: Icons.shield_rounded,
            iconColor: const Color(0xFF22D3EE),
          ),
          const SizedBox(height: 20),

          // Creator & Portfolio Section
          Text(
            'CREATOR & LEAD ENGINEER',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF22D3EE),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          // Creator Profile Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF131A3A), Color(0xFF0F1530)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF22D3EE), Color(0xFF6366F1)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'JC',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jay Chauhan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Backend & AI Engineer | GenAI Specialist',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Credentials Badges
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildBadge('🎓 Google DSC Lead (Alum)', const Color(0xFF4285F4)),
                    _buildBadge('🛡️ Microsoft Student Ambassador', const Color(0xFF00A4EF)),
                    _buildBadge('💼 Arhamshare', const Color(0xFF10B981)),
                    _buildBadge('📍 Surat, India', const Color(0xFFA855F7)),
                  ],
                ),
                const SizedBox(height: 14),

                Text(
                  'Passionate about building scalable distributed backends and privacy-centric edge AI applications. Focused on democratizing offline AI models on mobile hardware.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    height: 1.5,
                    color: const Color(0xFFCBD5E1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Connect Links
          Text(
            'CONNECT & PORTFOLIO',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF22D3EE),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          _buildLinkTile(
            icon: Icons.language_rounded,
            title: 'Official Website',
            subtitle: 'jaychauhan.tech',
            color: const Color(0xFF22D3EE),
            onTap: () => _open(context, _website),
          ),
          const SizedBox(height: 8),

          _buildLinkTile(
            icon: Icons.code_rounded,
            title: 'GitHub',
            subtitle: 'github.com/Jay3Chauhan',
            color: const Color(0xFFE2E8F0),
            onTap: () => _open(context, _github),
          ),
          const SizedBox(height: 8),

          _buildLinkTile(
            icon: Icons.business_center_rounded,
            title: 'LinkedIn',
            subtitle: 'in/jay-chauhan-5a65921ba',
            color: const Color(0xFF0A66C2),
            onTap: () => _open(context, _linkedin),
          ),
          const SizedBox(height: 8),

          _buildLinkTile(
            icon: Icons.alternate_email_rounded,
            title: 'X / Twitter',
            subtitle: '@Jay3_Chauhan',
            color: const Color(0xFF38BDF8),
            onTap: () => _open(context, _twitter),
          ),
          const SizedBox(height: 8),

          _buildLinkTile(
            icon: Icons.mail_outline_rounded,
            title: 'Contact Email',
            subtitle: 'contact@jaychauhan.tech',
            color: const Color(0xFFF59E0B),
            onTap: () => _open(context, _email),
          ),
          const SizedBox(height: 8),

          _buildLinkTile(
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            subtitle: 'app.notion.com/p/AI-Vance',
            color: const Color(0xFF10B981),
            onTap: () => _open(context, _privacyPolicy),
          ),
          const SizedBox(height: 24),

          // Open Source License Notice
          Center(
            child: Text(
              'Licensed under GNU General Public License v3.0\nBuilt with Flutter & llama.cpp',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildCard({
    required ColorScheme colorScheme,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1530),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              height: 1.55,
              color: const Color(0xFFCBD5E1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF0F1530),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

